set -e

eselect blas set reference
eselect lapack set reference
python2 -c "import scipy as np; np.test('full', verbose=3)"
python3 -c "import scipy as np; np.test('full', verbose=3)"

eselect blas set blis
eselect lapack set reference
python2 -c "import scipy as np; np.test('full', verbose=3)"
python3 -c "import scipy as np; np.test('full', verbose=3)"

eselect blas set openblas
eselect lapack set openblas
python2 -c "import scipy as np; np.test('full', verbose=3)"
python3 -c "import scipy as np; np.test('full', verbose=3)"
