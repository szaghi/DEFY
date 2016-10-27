### Goto-if elseif-select case performance comparison, test 3

This test compare (computed) `goto` with `if elseif` and `select case` branching-flow constructs.

The keywords are ordered as following:

+ keys value:
  + key(1) = 3
  + key(2) = 4
  + key(3) = 1
  + key(4) = 2
+ keys probability:
  + key(1) ~ 36% (10 matches on 28)
  + key(2) ~ 29% (8  matches on 28)
  + key(3) ~ 21% (6  matches on 28)
  + key(4) ~ 14% (4  matches on 28)

> The *work* done inside the *workers* called by each branch is not uniform rather it depends on keywords value.

### Run test

Four bash scripts are provided to run the test:

1. `run_gnu.sh`, run the test with GNU gfortran compiler without optimizations;
2. `run_gnu_optimized.sh`, run the test with GNU gfortran compiler with optimizations;
3. `run_gnu.sh`, run the test with Intel Fortran Compiler without optimizations;
4. `run_gnu_optimized.sh`, run the test with Intel Fortran Compiler with optimizations;

### Results obtained

|Compiler (target)    |Optimizations|Architecture                                       | goto      | if elseif | select case |
|---------------------|-------------|---------------------------------------------------|-----------|-----------|-------------|
| GNU 6.2.0 (64bit)   | -O3         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu |0.1111^10-3|0.1111^10-3|0.1111 ^10-3 |
| GNU 6.2.0 (64bit)   | -Og         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu |0.2136^10-2|0.2135^10-2|0.2137 ^10-2 |
| Intel 16.0.3 (64bit)| -O3         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu |0.1143^10-3|0.1143^10-3|0.1154 ^10-3 |
| Intel 16.0.3 (64bit)| -O0         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu |0.2691^10-2|0.2691^10-2|0.2691 ^10-2 |
| GNU 7.0.0 (32bit)   | -??         |Intel Core i5-2400@3.10GHz, 4GB RAM, Windows 64-bit|0.4360^10-3|0.4358^10-3|0.4359 ^10-3 |
| Intel 17.0.0 (64bit)| -O2         |Intel Core i5-2400@3.10GHz, 4GB RAM, Windows 64-bit|0.1450^10-3|0.1506^10-3|0.1443 ^10-3 |
