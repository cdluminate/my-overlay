tester="
import time
import numpy as np
print(np.__version__, np.__path__)
#x = np.random.random((4096,4096))
x = np.random.random((512,512))
time_s = time.time()
y = x @ x
time_e = time.time()
print(time_e - time_s)
"

foobar () {
	for x in $(qlist numpy | grep '.so$'); do
		readelf -d $x | grep '(NEEDED)';
	done
}

foobar | sort | uniq

export OMP_NUM_THREADS=4

LD_LIBRARY_PATH=/usr/lib64/blas/reference python3 -c "$tester"
LD_LIBRARY_PATH=/usr/lib64/blas/blis      python3 -c "$tester"
