set -ex
g++ test-gemm.cc -lcblas -o test-gemm
export BLIS_NUM_THREADS=4

LD_LIBRARY_PATH=/usr/lib64/blas/reference ./test-gemm
LD_LIBRARY_PATH=/usr/lib64/blas/blis ./test-gemm

eselect blas set reference || true
./test-gemm
eselect blas set blis || true
./test-gemm
