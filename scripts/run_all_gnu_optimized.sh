#!/bin/bash
# script to build and run all DEFY tests.
#
# License: this file is licensed under the Creative Commons Attribution 4.0 license,
# see http://creativecommons.org/licenses/by/4.0/ .

for e in $( find ./src/ -type f -executable -print | grep run_gnu_optimized); do
  here=$(pwd)
  dir=$(dirname $e)
  bdir=$(basename $dir)
  exe=$(basename $e)
  echo $bdir
  cd $dir
  ./$exe > $here/$bdir.log
  cd -
done
cat /proc/cpuinfo > cpu.log
cat /proc/meminfo > mem.log
uname -a > os.log
tar --xform="s%^%DEFY-travis-tests/%" -czf DEFY-travis-tests.tar.gz *.log
rm -f *.log
exit 0
