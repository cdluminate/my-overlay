import time
import numpy as np
#x = np.random.random((4096,4096))
x = np.random.random((512,512))
time_s = time.time()
y = x @ x
time_e = time.time()
print(time_e - time_s)
