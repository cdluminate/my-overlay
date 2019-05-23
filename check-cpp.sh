set -ex
g++ -Wall -O2 test-gemm.cc -lcblas -o test-gemm
g++ -Wall -O2 test-gesvd.cc -llapacke -o test-gesvd
export BLIS_NUM_THREADS=4

LD_LIBRARY_PATH=/usr/lib64/blas/reference ./test-gemm
LD_LIBRARY_PATH=/usr/lib64/blas/reference ./test-gesvd
LD_LIBRARY_PATH=/usr/lib64/blas/blis ./test-gemm
LD_LIBRARY_PATH=/usr/lib64/blas/blis ./test-gesvd

eselect blas set reference || true
./test-gemm
./test-gesvd
eselect blas set blis || true
./test-gemm
./test-gesvd
