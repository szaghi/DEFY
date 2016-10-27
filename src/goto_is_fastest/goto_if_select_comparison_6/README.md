### Goto-if elseif-select case performance comparison, test 6

This test compare (computed) `goto` with `if elseif` and `select case` branching-flow constructs.

> The selector for the branching-jump is computed pseudo-randomically.

> The *work* done inside the *workers* called by each branch is not uniform rather it depends on keywords value.

This is a modification of [goto-if elseif-select case 5](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_select_comparison_5) where the code has been modified to be compiled with an old Compaq Visual Fortran compiler.

### Run test

Four bash scripts are provided to run the test:

1. `run_intel.sh`, run the test with Intel Fortran Compiler without optimizations;
2. `run_intel_optimized.sh`, run the test with Intel Fortran Compiler with optimizations;

### Results obtained

|Compiler (target)    |Optimizations|Architecture                                         | goto      | if elseif | select case |
|---------------------|-------------|-----------------------------------------------------|-----------|-----------|-------------|
| GNU 6.2.0 (64bit)   | -O3         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu   |0.7245^10-5|1.0841^10-5| 0.5429^10-5 |
| GNU 6.2.0 (64bit)   | -Og         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu   |0.9998^10-4|0.9892^10-4| 0.9791^10-4 |
| Intel 16.0.3 (64bit)| -O3         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu   |0.5343^10-5|0.6552^10-5| 0.6181^10-5 |
| Intel 16.0.3 (64bit)| -O0         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu   |0.1093^10-3|0.1105^10-3| 0.1231^10-3 |
| Compaq 6.6a (32bit) | -O2         |Intel Core i5-2400@3.10GHz, 4GB RAM, Windows 64-bit  |0.3100^10-4|0.3000^10-4| 0.3000^10-4 |
| Intel 17.0.0 (64bit)| -O2         |Intel Core i5-2400@3.10GHz, 4GB RAM, Windows 64-bit  |0.1100^10-4|0.1000^10-4| 0.0800^10-4 |

In general, for the above test the keywords distributions observed are similar to the following for all tests:

| Keyword | Average keywords distribution |
|---------|-------------------------------|
|    1    |     4.97%                     |
|    2    |     4.97%                     |
|    3    |     5.06%                     |
|    4    |     5.17%                     |
|    5    |     4.81%                     |
|    6    |     4.95%                     |
|    7    |     4.90%                     |
|    8    |     4.93%                     |
|    9    |     4.61%                     |
|    10   |     4.77%                     |
|    11   |     5.09%                     |
|    12   |     4.89%                     |
|    13   |     5.15%                     |
|    14   |     5.47%                     |
|    15   |     5.01%                     |
|    16   |     4.55%                     |
|    17   |     5.10%                     |
|    18   |     5.16%                     |
|    19   |     5.29%                     |
|    20   |     2.65%                     |
