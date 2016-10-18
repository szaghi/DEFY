### Compare peformances of different powers definitions

To be written.

### Run test

Four bash scripts are provided to run the test:

1. `run_gnu.sh`, run the test with GNU gfortran compiler without optimizations;
2. `run_gnu_optimized.sh`, run the test with GNU gfortran compiler with optimizations;
3. `run_gnu.sh`, run the test with Intel Fortran Compiler without optimizations;
4. `run_gnu_optimized.sh`, run the test with Intel Fortran Compiler with optimizations;

### Results obtained

|Compiler|Optimizations|Architecture                                    |  a*a   |  a**2  | a**2.0 |a**2.0_real64|
|--------|-------------|------------------------------------------------|--------|--------|--------|-------------|
| GNU    |   yes       |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian|0.057749|0.061242|0.059180|   0.059963  |
| GNU    |   no        |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian|0.075604|0.076985|0.188435|   0.176926  |
| Intel  |   yes       |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian|0.074263|0.077053|0.066916|   0.066274  |
| Intel  |   no        |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian|0.129806|0.148482|0.120632|   0.117112  |

|Compiler|Optimizations|Architecture                                    | sqrt(a)| a**0.5 | a**0.5_real64|
|--------|-------------|------------------------------------------------|--------|--------|--------|
| GNU    |   yes       |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian|0.112347|1.094111|1.094577|
| GNU    |   no        |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian|0.113749|1.097284|1.100870|
| Intel  |   yes       |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian|0.077185|0.076015|0.074920|
| Intel  |   no        |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian|0.170241|0.169863|0.169951|
