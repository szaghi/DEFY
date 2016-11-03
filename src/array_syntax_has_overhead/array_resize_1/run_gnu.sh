#!/bin/bash
# script to build and run DEFY tests.
#
# License: this file is licensed under the Creative Commons Attribution 4.0 license,
# see http://creativecommons.org/licenses/by/4.0/ .

test=$(basename $(pwd))/defy.f90
echo "Build and run $test by means of 'gfortran -Og'"
gfortran -Og -frealloc-lhs defy.f90 -o defy
./defy
rm -f defy
