### Abstract OOD has relevant overhead with respect non abstract equivalent design

This test compare the performance of an abstract OOD type with respect an equivalent non abstract type.

To be completed.

### Run test

Four bash scripts are provided to run the test:

1. `run_gnu.sh`, run the test with GNU gfortran compiler without optimizations;
2. `run_gnu_optimized.sh`, run the test with GNU gfortran compiler with optimizations;
3. `run_gnu.sh`, run the test with Intel Fortran Compiler without optimizations;
4. `run_gnu_optimized.sh`, run the test with Intel Fortran Compiler with optimizations;

### Results obtained

|Compileri (target)   |Optimizations|Architecture                                         | non abstract| abstract  |
|---------------------|-------------|-----------------------------------------------------|-------------|-----------|
| GNU 6.2.1 (64bit)   | -O3         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|20.099       |23.057     |
| GNU 6.2.1 (64bit)   | -Og         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|21.052       |20.365     |
| Intel 16.0.3 (64bit)| -O3         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|11.429       |13.697     |
| Intel 16.0.3 (64bit)| -O0         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|28.486       |21.943     |
