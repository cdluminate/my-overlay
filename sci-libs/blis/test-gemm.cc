#include <iostream>
#include <cstdlib>
#include <cassert>

//#include <cblas.h>
//#include <mkl.h>
#include <blis/cblas.h>  /* MKL - CBLAS Part */

#include <sys/time.h>

// This file is used to test correctness of cblas header / library packaging.
// Although can be used as a very rough benchmarker.
// g++ test-gemm.cc $(pkg-config --libs --cflags mkl-rt)

const int iteration = 5; // how many iterations would you like to run
const int repeat = 100; // repeat several times in each iteration
const int M = 128; // matrix size (M * M) used for testing
const bool debug = false; // dump the matrices?

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
main(void)
{
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
	fprintf(stdout, "Sanity Test Error: %lf\n", (double)error);
	assert(error < 1e-9);

	// start iterations
	for (int t = 0; t < iteration; t++) {

		// fill the matrices and run dgemm for several times
		for (int i = 0; i < M*M; i++) {
			x[i] = (PREC_T)drand48(); 
			y[i] = (PREC_T)drand48();
		}

		// run dgemm
		gettimeofday(&tv_start, nullptr);
		for (int i = 0; i < repeat; i++) {
			GEMM(CblasRowMajor, CblasNoTrans, CblasNoTrans,
				M, M, M, 1., x, M, y, M, 0., z, M);
			GEMM(CblasRowMajor, CblasTrans, CblasNoTrans,
				M, M, M, 1., x, M, y, M, 0., z, M);
			GEMM(CblasRowMajor, CblasNoTrans, CblasTrans,
				M, M, M, 1., x, M, y, M, 0., z, M);
			GEMM(CblasRowMajor, CblasTrans, CblasTrans,
				M, M, M, 1., x, M, y, M, 0., z, M);
		}
		gettimeofday(&tv_end, nullptr);
		fprintf(stdout, "(%d/%d) Elapsed %.3lf ms\n", t+1, repeat,
				(tv_end.tv_sec*1e6 + tv_end.tv_usec
				 - tv_start.tv_sec*1e6  - tv_start.tv_usec)/1e3);
	}

	return 0;
}
