tester="
import time
import numpy as np
N=512
x = np.random.rand(N,N).astype(np.float)
time_s = time.time()
y = x @ x
time_e = time.time()
print(np.__version__, np.__path__, ' GEMM', time_e - time_s)
"
tester_svd="
import time
import numpy as np
N=512
x = np.random.rand(N,N).astype(np.float)
time_s = time.time()
y = np.linalg.svd(x)
time_e = time.time()
print(np.__version__, np.__path__, 'GESVD', time_e - time_s, np.abs(y[0] @ np.diag(y[1]) @ y[2] - x).sum())
"

foobar () {
	for x in $(qlist numpy | grep '.so$'); do
		readelf -d $x;
	done
}

foobar | grep '(NEEDED)' | sort | uniq
foobar

export BLIS_NUM_THREADS=4

LD_LIBRARY_PATH=/usr/lib64/blas/reference python3 -c "$tester"
LD_LIBRARY_PATH=/usr/lib64/blas/reference python3 -c "$tester_svd"
LD_LIBRARY_PATH=/usr/lib64/blas/blis      python3 -c "$tester"
LD_LIBRARY_PATH=/usr/lib64/blas/blis      python3 -c "$tester_svd"

for y in reference blis; do
	echo '-------------------------------------------------'
	for x in blas cblas lapack; do
		eselect $x set $y
	done
	for x in blas cblas lapack; do
		eselect $x list
	done
	python3 -c "$tester"
	python3 -c "$tester_svd"
done

echo '====================================================='
ls /usr/lib64/libblas* -l
ls /usr/lib64/libcblas* -l
ls /usr/lib64/liblapack* -l
for x in blas cblas lapack; do
	eselect $x list
done

#export BLIS_NUM_THREADS=4
#export OPENBLAS_NUM_THREADS=4
#LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/openblas/     python3 -c "$tester"
#LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/blis-openmp/  python3 -c "$tester"
#LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/blis-pthread/ python3 -c "$tester"
#LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/blis-serial/  python3 -c "$tester"
#LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/atlas/        python3 -c "$tester"
#LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/blas/         python3 -c "$tester"
