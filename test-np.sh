set -e

#eselect blas set reference
#eselect lapack set reference
#python2 -c "import numpy as np; np.test('full', verbose=3)"
#python3 -c "import numpy as np; np.test('full', verbose=0)" #OK

#eselect blas set blis
#eselect lapack set reference
#python2 -c "import numpy as np; np.test('full', verbose=3)"
#python3 -c "import numpy as np; np.test('full', verbose=0)" # OK
#
eselect blas set openblas
eselect lapack set openblas
#python2 -c "import numpy as np; np.test('full', verbose=3)"
#python3 -c "import numpy as np; np.test('full', verbose=0)"  # ok
