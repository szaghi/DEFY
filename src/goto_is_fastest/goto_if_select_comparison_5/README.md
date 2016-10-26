### Goto-if elseif-select case performance comparison, test 5

This test compare (computed) `goto` with `if elseif` and `select case` branching-flow constructs.

> The selector for the branching-jump is computed pseudo-randomically.

> The *work* done inside the *workers* called by each branch is not uniform rather it depends on keywords value.

This is a modification of [goto-if elseif-select case](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_select_comparison_1) test where the number of branches is augmented up to 20. In this case the optimizers should not compile the branching into a sequential tests rather into an indexed table, the number of branches being more than 4. Moreover, the timing of the 3 constructs are separated into different procedures thus to prevent compilers optimizer to inline the call of workers for each keyword.

### Run test

Four bash scripts are provided to run the test:

1. `run_gnu.sh`, run the test with GNU gfortran compiler without optimizations;
2. `run_gnu_optimized.sh`, run the test with GNU gfortran compiler with optimizations;
3. `run_gnu.sh`, run the test with Intel Fortran Compiler without optimizations;
4. `run_gnu_optimized.sh`, run the test with Intel Fortran Compiler with optimizations;

### Results obtained

|Compiler (target)    |Optimizations|Architecture                                         | goto      | if elseif | select case |
|---------------------|-------------|-----------------------------------------------------|-----------|-----------|-------------|
| GNU 6.2.0 (64bit)   | -O3         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.9421^10-4|0.9313^10-4| 0.9488^10-4 |
| GNU 6.2.0 (64bit)   | -Og         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.1087^10-2|0.1049^10-2| 0.1096^10-2 |
| Intel 16.0.3 (64bit)| -O3         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.8915^10-4|0.9179^10-4| 0.9170^10-4 |
| Intel 16.0.3 (64bit)| -O0         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.1287^10-2|0.1287^10-2| 0.1307^10-2 |

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
