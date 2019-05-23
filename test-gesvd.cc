// This file is used to test correctness of lapacke packaging.
// g++ test-gesvd.cc $(pkg-config --libs --cflags mkl-rt)
// Author: M. Zhou <lumin@debian.org>

#include <iostream>
#include <cstdlib>
#include <cassert>
#include <sys/time.h>

#include <lapacke.h>
//#include <mkl.h>
//#include <mkl_lapacke.h>  /* MKL - CBLAS Part */

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
	PREC_T* A = (PREC_T*)malloc(sizeof(PREC_T) * M * M);
	PREC_T* U = (PREC_T*)malloc(sizeof(PREC_T) * M * M);
	PREC_T* S = (PREC_T*)malloc(sizeof(PREC_T) * M);
	PREC_T* VT = (PREC_T*)malloc(sizeof(PREC_T) * M * M);
	PREC_T* superb = (PREC_T*)malloc(sizeof(PREC_T) * M);

	printf("Matrix Size: [%d,%d], sizeof(type) [%d], Sanity Check [OK]\n",
			M, M, sizeof(PREC_T));

	// start iterations
	for (int t = 0; t < iteration; t++) {

		// fill the matrices and run dgemm for several times
		for (int i = 0; i < M*M; i++) {
			A[i] = (PREC_T)drand48(); 
		}

		// run dgemm
		gettimeofday(&tv_start, nullptr);
		LAPACKE_sgesvd(
				LAPACK_ROW_MAJOR, 'A', 'A',
			   	M, M, A, M, S, U, M, VT, M, superb
				);
		gettimeofday(&tv_end, nullptr);
		
		// report elapsed time
		fprintf(stdout, "Iter(%d/%d) Elapsed %.3lf ms\n", t+1, iteration,
				(tv_end.tv_sec*1e6 + tv_end.tv_usec
				 - tv_start.tv_sec*1e6  - tv_start.tv_usec)/1e3);
	}
	free(A); free(U); free(S); free(VT); free(superb);

	return 0;
}
