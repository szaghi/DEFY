### Goto-if elseif-select case performance comparison, test 2

This test compare (computed) `goto` with `select case` branching-flow constructs.

To be completed.

### Run test

Four bash scripts are provided to run the test:

1. `run_gnu.sh`, run the test with GNU gfortran compiler without optimizations;
2. `run_gnu_optimized.sh`, run the test with GNU gfortran compiler with optimizations;
3. `run_gnu.sh`, run the test with Intel Fortran Compiler without optimizations;
4. `run_gnu_optimized.sh`, run the test with Intel Fortran Compiler with optimizations;

### Results obtained

|Compiler (target)    |Optimizations|Architecture                                      | goto      |select case |
|---------------------|-------------|--------------------------------------------------|-----------|------------|
| Intel 16.0.3 (64bit)| -O3         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|2.0460^10-3|2.0394^10-3 |
| Intel 16.0.3 (64bit)| -O0         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|3.4972^10-3|4.0245^10-3 |
