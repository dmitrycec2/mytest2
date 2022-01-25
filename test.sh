#!/bin/bash
#
# Test the JMeter Docker image using a trivial test plan.

# Example for using User Defined Variables with JMeter
# These will be substituted in JMX test script
# See also: http://stackoverflow.com/questions/14317715/jmeter-changing-user-defined-variables-from-command-line


T_DIR=tests/trivial
R_DIR=${T_DIR}/report

# Reporting dir: start fresh
rm -rf ${R_DIR} > /dev/null 2>&1
mkdir -p ${R_DIR}
pwd
echo "==== 111111111111 ===="
./run.sh $1 ${T_DIR} ${R_DIR}

echo "==== jmeter.log ===="
cat ${R_DIR}/jmeter.log

echo "==== Raw Test Report ===="
cat ${R_DIR}/UC02.jtl

echo "==== HTML Test Report ===="
echo "See HTML test report in ${R_DIR}/index.html"
