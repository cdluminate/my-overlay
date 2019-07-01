set -e

#eselect blas set reference
#eselect lapack set reference
#python2 -c "import scipy as np; np.test('full', verbose=3)"  # OK
#python3 -c "import scipy as np; np.test('full', verbose=3)"  # OK

eselect blas set blis
eselect lapack set reference
#python2 -c "import scipy as np; np.test('full', verbose=0)"
#python3 -c "import scipy as np; np.test('full', verbose=0)" # 10 FAIL
python3 -c "import scipy as np; np.test('fast', verbose=False)" # 10 FAIL
#
#eselect blas set openblas
#eselect lapack set openblas
#python2 -c "import scipy as np; np.test('full', verbose=3)"  # OK
#python3 -c "import scipy as np; np.test('full', verbose=0)"  # OK
