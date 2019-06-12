set -ex
test -x test-gemm || g++ -Wall -O2 test-gemm.cc -lcblas -o test-gemm
test -x test-gesvd || g++ -Wall -O2 test-gesvd.cc -llapacke -o test-gesvd

#LD_LIBRARY_PATH=/usr/lib64/blas/reference ./test-gemm
#LD_LIBRARY_PATH=/usr/lib64/blas/reference ./test-gesvd
#LD_LIBRARY_PATH=/usr/lib64/blas/blis ./test-gemm
#LD_LIBRARY_PATH=/usr/lib64/blas/blis ./test-gesvd

reset () {
	eselect blas set lib64 reference || true
	eselect lapack set lib64 reference || true
}

reset

eselect blas set lib64 reference || true
./test-gemm
./test-gesvd

eselect blas set lib64 blis || true
./test-gemm
./test-gesvd

eselect blas set lib64 openblas || true
eselect lapack set lib64 openblas || true
./test-gemm
./test-gesvd

reset
# Power9: 4 Threads: test-gemm: reference(360ms) blis(70ms) openblas(4ms)
# Power9: 4 Threads: test-gesvd: reference(1800ms) blis(1500ms) openblas(1100ms)
