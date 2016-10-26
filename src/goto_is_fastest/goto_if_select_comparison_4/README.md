### Goto-if elseif-select case performance comparison, test 4

This test compare (computed) `goto` with `if elseif` and `select case` branching-flow constructs.

> The selector for the branching-jump is computed pseudo-randomically.

> The *work* done inside the *workers* called by each branch is not uniform rather it depends on keywords value.

This is a modification of [goto-if elseif-select case](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_select_comparison_1) test where the number of branches is augmented up to 20. In this case the optimizers should not compile the branching into a sequential tests rather into an indexed table, the number of branches being more than 4.

### Run test

Four bash scripts are provided to run the test:

1. `run_gnu.sh`, run the test with GNU gfortran compiler without optimizations;
2. `run_gnu_optimized.sh`, run the test with GNU gfortran compiler with optimizations;
3. `run_gnu.sh`, run the test with Intel Fortran Compiler without optimizations;
4. `run_gnu_optimized.sh`, run the test with Intel Fortran Compiler with optimizations;

### Results obtained

|Compiler (target)    |Optimizations|Architecture                                         | goto      | if elseif | select case |
|---------------------|-------------|-----------------------------------------------------|-----------|-----------|-------------|
| GNU 6.2.0 (64bit)   | -O3         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.9578^10-4|0.9587^10-4| 0.9586^10-4 |
| GNU 6.2.0 (64bit)   | -Og         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.1056^10-2|0.1056^10-2| 0.1050^10-2 |
| Intel 16.0.3 (64bit)| -O3         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.9463^10-4|0.9471^10-4| 0.9479^10-4 |
| Intel 16.0.3 (64bit)| -O0         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.1301^10-2|0.1299^10-2| 0.1302^10-2 |
