### Goto-if elseif-select case performance comparison, test 1

This test compare (computed) `goto` with `if elseif` and `select case` branching-flow constructs. The selector for the branching-jump is computed pseudo-randomically and the *work* done inside the *workers* called by each branch is not uniform.

### Run test

Four bash scripts are provided to run the test:

1. `run_gnu.sh`, run the test with GNU gfortran compiler without optimizations;
2. `run_gnu_optimized.sh`, run the test with GNU gfortran compiler with optimizations;
3. `run_gnu.sh`, run the test with Intel Fortran Compiler without optimizations;
4. `run_gnu_optimized.sh`, run the test with Intel Fortran Compiler with optimizations;

### Results obtained

|Compiler|Optimizations|Architecture                                         | goto      | if elseif | select case |
|--------|-------------|-----------------------------------------------------|-----------|-----------|-------------|
| GNU    |   yes       |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.3852^10-4|0.3856^10-4| 0.3857^10-4 |
| GNU    |   no        |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.5788^10-3|0.5778^10-3| 0.5783^10-3 |
| Intel  |   yes       |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.3896^10-4|0.3913^10-4| 0.3905^10-4 |
| Intel  |   no        |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.5796^10-3|0.5785^10-3| 0.5810^10-3 |
