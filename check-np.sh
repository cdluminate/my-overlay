set -e
export BLIS_NUM_THREADS=4
export OPENBLAS_NUM_THREADS=4

tester="
import time
import numpy as np
N=512
x = np.random.rand(N,N).astype(np.float)
time_s = time.time()
y = x @ x
time_e = time.time()
print(' GEMM', time_e - time_s)
#print(np.__version__, np.__path__, ' GEMM', time_e - time_s)
"
tester_svd="
import time
import numpy as np
N=512
x = np.random.rand(N,N).astype(np.float)
time_s = time.time()
y = np.linalg.svd(x)
time_e = time.time()
print('GESVD', time_e - time_s, np.abs(y[0] @ np.diag(y[1]) @ y[2] - x).sum())
#print(np.__version__, np.__path__, 'GESVD', time_e - time_s, np.abs(y[0] @ np.diag(y[1]) @ y[2] - x).sum())
"

foobar () {
	for x in $(qlist numpy | grep '.so$'); do
		readelf -d $x;
	done
}

echo '### numpy -- readelf results ###'
foobar | grep '(NEEDED)' | sort | uniq
#foobar
echo '-------------------------------------------------'

echo '### numpy -- eselect switching results ###'
for lapack in reference openblas; do
	for blas in reference blis openblas; do
		echo '-------------------------------------------------'
		eselect blas set $blas
		eselect lapack set $lapack
		echo "[48;5;93m USING BLAS=$blas LAPACK=$lapack [m"
		python3 -c "$tester"
		python3 -c "$tester_svd"
	done
done
