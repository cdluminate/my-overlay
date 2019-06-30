set -e

eselect set blas reference
eselect set lapack reference
python2 -c "import numpy as np; np.test('full', verbose=3)"
python3 -c "import numpy as np; np.test('full', verbose=3)"

eselect set blas blis
eselect set lapack reference
python2 -c "import numpy as np; np.test('full', verbose=3)"
python3 -c "import numpy as np; np.test('full', verbose=3)"

eselect set blas openblas
eselect set lapack openblas
python2 -c "import numpy as np; np.test('full', verbose=3)"
python3 -c "import numpy as np; np.test('full', verbose=3)"
