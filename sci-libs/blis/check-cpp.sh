g++ test-gemm.cc -lblas -o test-gemm

LD_LIBRARY_PATH=/usr/lib64/blas/reference ./test-gemm
LD_LIBRARY_PATH=/usr/lib64/blas/blis ./test-gemm
