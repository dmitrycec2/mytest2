#!/bin/bash
# Inspired from https://github.com/hhcordero/docker-jmeter-client
# Basically runs jmeter, assuming the PATH is set to point to JMeter bin-dir (see Dockerfile)
#
# This script expects the standdard JMeter command parameters.
#

# Install jmeter plugins available on /plugins volume
if [ -d /plugins ]
then
    for plugin in /plugins/*.jar; do
        cp $plugin $(pwd)/lib/ext
    done;
fi

# Execute JMeter command
set -e
freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"

echo "START Running Jmeter on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=$@"

# Keep entrypoint simple: we must pass the standard JMeter arguments
#jmeter $@
T_DIR=${2}
R_DIR=${3}
echo "------------"+${T_DIR}
#if [ $1 = "UC_251_NEWFILE_run" ]; then
chmod +x ${T_DIR}/${1}
sh ${T_DIR}/${1} ${T_DIR} ${R_DIR} ${JVM_ARGS}
#fi
#wait -n
