#!/bin/bash
PYTHON=${PYTHON-python}
NODE_BIN=${NODE_BIN-node}
NPM=${NPM-npm}
FLAKE8=${FLAKE8-flake8}
COVERAGE=${COVERAGE-coverage}

echo setup.py tests
$PYTHON setup.py test $TEST_ARGS
setuptests=$?
if [ $setuptests -ne 0 ] ; then
  echo "setup.py test does not run properly"
  exit 1
fi
$COVERAGE html

echo Linting
$FLAKE8 --max-line-length=100 \
	taskcluster test
lint=$?
if [ $lint -ne 0 ] ; then
  echo "Code is not formatted correctly"
  exit 1
fi
echo Done linting

echo Done testing!

exit $(( lint + setuptests ))
