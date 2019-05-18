set -ex
g++ test-gemm.cc -lcblas -o test-gemm
export BLIS_NUM_THREADS=4

LD_LIBRARY_PATH=/usr/lib64/blas/reference ./test-gemm
LD_LIBRARY_PATH=/usr/lib64/blas/blis ./test-gemm

eselect cblas set reference || true
if ! test -r /usr/lib64/libcblas.so.3; then
	ln -s libcblas.so.0 /usr/lib64/libcblas.so.3
fi
./test-gemm
eselect cblas set blis || true
./test-gemm
