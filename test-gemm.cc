// This file is used to test correctness of blas packaging.
// g++ test-gemm.cc $(pkg-config --libs --cflags mkl-rt)
// Author: M. Zhou <lumin@debian.org>

#include <iostream>
#include <cstdlib>
#include <cassert>
#include <sys/time.h>

#include <cblas.h>
//#include <mkl.h>
//#include <mkl_cblas.h>  /* MKL - CBLAS Part */

#define _GEMM(T) cblas_##T##gemm
#define _AXPY(T) cblas_##T##axpy
#define _ASUM(T) cblas_##T##asum

#if !defined(USE_DOUBLE)
#define PREC_T float
#define GEMM _GEMM(s)
#define AXPY _AXPY(s)
#define ASUM _ASUM(s)
#else
#define PREC_T double
#define GEMM _GEMM(d)
#define AXPY _AXPY(d)
#define ASUM _ASUM(d)
#endif

#if !defined BlasInt
#define BlasInt __int32_t
#endif

void
xdump2(const size_t m, const size_t n, const PREC_T* x, const size_t incx)
// dump a M by N matrix.
{
	for (size_t i = 0; i < m; i++) {
		for (size_t j = 0; j < n; j++)
			printf(" %lf", x[i*m + j]);
		printf("\n");
	}
}

int
main(int argc, char* argv[])
{
	int iteration = 5; // how many iterations would you like to run
	int M = 512; // matrix size (M * M) used for testing
	bool debug = false; // dump the matrices?

	// read env variable and cmd args
	if (getenv("M")) {
		M = atoi(getenv("M"));
	}
	if (argc > 1) {
		M = atoi(argv[1]);
	}

	struct timeval tv_start, tv_end;
	PREC_T* x = (PREC_T*)malloc(sizeof(PREC_T) * M * M);
	PREC_T* y = (PREC_T*)malloc(sizeof(PREC_T) * M * M);
	PREC_T* z = (PREC_T*)malloc(sizeof(PREC_T) * M * M);

	// check sanity first. Doing things fast but wrong is in vain.
	for (int i = 0; i < M*M; i++) {
		x[i] = (PREC_T)drand48();
	}
	for (int i = 0; i < M; i++) {
		y[i*M + i] = 1.;
	}
	if (debug) xdump2(M, M, x, 1);
	if (debug) xdump2(M, M, y, 1);
	GEMM(CblasRowMajor, CblasNoTrans, CblasNoTrans,
			M, M, M, 1., x, M, y, M, 0., z, M);  // z <- x * I
	if (debug) xdump2(M, M, z, 1);
	AXPY(M*M, -1., x, 1, z, 1); // z <- -x + z
	if (debug) xdump2(M, M, z, 1);
	PREC_T error = ASUM(M*M, z, 1);
	if (error >= 1e-9)
		fprintf(stdout, "Sanity Test | Error: %lf\n", (double)error);
	assert(error < 1e-9);

	printf("Matrix Size: [%d,%d], sizeof(type) [%d], Sanity Check [OK]\n",
			M, M, sizeof(PREC_T));

	// start iterations
	for (int t = 0; t < iteration; t++) {

		// fill the matrices and run dgemm for several times
		for (int i = 0; i < M*M; i++) {
			x[i] = (PREC_T)drand48(); 
			y[i] = (PREC_T)drand48();
		}

		// run dgemm
		gettimeofday(&tv_start, nullptr);
		GEMM(CblasRowMajor, CblasNoTrans, CblasNoTrans,
			M, M, M, 1., x, M, y, M, 0., z, M);
		GEMM(CblasRowMajor, CblasTrans, CblasNoTrans,
			M, M, M, 1., x, M, y, M, 0., z, M);
		GEMM(CblasRowMajor, CblasNoTrans, CblasTrans,
			M, M, M, 1., x, M, y, M, 0., z, M);
		GEMM(CblasRowMajor, CblasTrans, CblasTrans,
			M, M, M, 1., x, M, y, M, 0., z, M);
		gettimeofday(&tv_end, nullptr);
		
		// report mean elapsed time for 4 runs
		fprintf(stdout, "Iter(%d/%d) Elapsed %.3lf ms\n", t+1, iteration,
				(tv_end.tv_sec*1e6 + tv_end.tv_usec
				 - tv_start.tv_sec*1e6  - tv_start.tv_usec)/4e3);
	}
	free(x); free(y); free(z);

	return 0;
}
