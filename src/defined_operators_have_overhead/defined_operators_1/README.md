### Defined operators have relevant overhead

This test compares the performance of different implementation of defined operators of derived type with respect equivalent intrinsic operators.

To be completed.

### Run test

Four bash scripts are provided to run the test:

1. `run_gnu.sh`, run the test with GNU gfortran compiler without optimizations;
2. `run_gnu_optimized.sh`, run the test with GNU gfortran compiler with optimizations;
3. `run_gnu.sh`, run the test with Intel Fortran Compiler without optimizations;
4. `run_gnu_optimized.sh`, run the test with Intel Fortran Compiler with optimizations;

### Results obtained

|Compileri (target)   |Optimizations|Architecture                                         | intrinsic | automatic | allocatable | polymorphic |
|---------------------|-------------|-----------------------------------------------------|-----------|-----------|-------------|-------------|
| GNU 6.3.1 (64bit)   | -O3         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.141      |0.229      |0.185        |  /          |
| GNU 6.3.1 (64bit)   | -Og         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.158      |0.384      |0.350        |  /          |
| Intel 17.0.2 (64bit)| -O3         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.100      |0.258      |0.242        |0.290        |
| Intel 17.0.2 (64bit)| -O0         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.814      |2.078      |1.726        |2.394        |
