### Compare performances of different powers definitions

Power elevations can be written in different form. Let us consider the square computation. It can be written as

+ `a*a`, by means the multiplication operator;
+ `a**2`, by means of the power operator using the integer constant `2`;
+ `a**2.0`, by means of the power operator using the real constant `2.0` with the default kind;
+ `a**2.0_real64`, by means of the power operator using the real constant `2.0` with the 64 bits kind;

> These definitions are not equivalent in terms of computational speed: they should be ordered form the fastest to the slowest.

Similarly, the square root can be written as:

+ `sqrt(a)`, by means the builtin `sqrt` function;
+ `a**0.5`, by means of the power operator using the real constant `0.5` with the default kind;
+ `a**0.5_real64`, by means of the power operator using the real constant `0.5` with the 64 bits kind;

> The trend is confirmed, but overheads are somehow less than expected.

### Run test

Four bash scripts are provided to run the test:

1. `run_gnu.sh`, run the test with GNU gfortran compiler without optimizations;
2. `run_gnu_optimized.sh`, run the test with GNU gfortran compiler with optimizations;
3. `run_gnu.sh`, run the test with Intel Fortran Compiler without optimizations;
4. `run_gnu_optimized.sh`, run the test with Intel Fortran Compiler with optimizations;

### Results obtained

#### Square

|Compiler (target)    |Optimizations|Architecture                                      | `a*a`  | `a**2` |`a**2.0`|`a**2.0_real64`|
|---------------------|-------------|--------------------------------------------------|--------|--------|--------|---------------|
| GNU x.y.z (64bit)   |   -O3       |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian  |0.057749|0.061242|0.059180|0.059963       |
| GNU x.y.z (64bit)   |   -Og       |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian  |0.075604|0.076985|0.188435|0.176926       |
| Intel x.y.z (64bit) |   -O3       |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian  |0.074263|0.077053|0.066916|0.066274       |
| Intel x.y.z (64bit) |   -O0       |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian  |0.129806|0.148482|0.120632|0.117112       |
| GNU 6.2.0 (64bit)   |   -O3       |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|0.014765|0.016203|0.016375|0.019350       |
| GNU 6.2.0 (64bit)   |   -Og       |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|0.044153|0.087174|0.123389|0.125654       |
| Intel 16.0.3 (64bit)|   -O3       |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|0.019858|0.020637|0.012919|0.015040       |
| Intel 16.0.3 (64bit)|   -O0       |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|0.068609|0.095346|0.078253|0.076377       |

#### Square root

|Compiler (target)    |Optimizations|Architecture                                      |`sqrt(a)`|`a**0.5`|`a**0.5_real64`|
|---------------------|-------------|--------------------------------------------------|---------|--------|---------------|
| GNU x.y.z (64bit)   |   -O3       |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian  |0.112347 |1.094111|1.094577       |
| GNU x.y.z (64bit)   |   -Og       |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian  |0.113749 |1.097284|1.100870       |
| Intel x.y.z (64bit) |   -O3       |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian  |0.077185 |0.076015|0.074920       |
| Intel x.y.z (64bit) |   -O0       |Intel Xeon E5440@2.83GHz, 8GB RAM, x86_64 Debian  |0.170241 |0.169863|0.169951       |
| GNU 6.2.0 (64bit)   |   -O3       |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|0.098565 |0.954313|0.984998       |
| GNU 6.2.0 (64bit)   |   -Og       |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|0.105412 |1.000769|1.011373       |
| Intel 16.0.3 (64bit)|   -O3       |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|0.015731 |0.021499|0.053096       |
| Intel 16.0.3 (64bit)|   -O0       |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|0.130754 |0.133923|0.196722       |
