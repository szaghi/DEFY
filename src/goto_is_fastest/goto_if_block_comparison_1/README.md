### Goto-if elseif-select case performance comparison, test 1

This test compare (computed) `goto` with `if` and `block (if)` branching-flow constructs.

> The selector for the branching-jump is computed pseudo-randomically.

> The *work* done inside the *workers* called by each branch is not uniform rather it depends on keywords value.

This is a modification of [goto-if elseif-select case](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_select_comparison_1) test proposed by Ron Shepard and further improved by FortranFan.

> Select case is not considered into this test (because it generates highly-nested branching-flow less clear than the others), rather the `block` construct.

Essentially, the branching-flow is now *flushed*: the selector selects *from which keyword* to start to call the workers and call not only the worker corresponding to that keyword, but also all subsequent workers, e.g.

```fortran
goto (1, 2, 3), keyword
1 call worker1(keyword)
2 call worker2(keyword)
3 call worker3(keyword)
```
if `keyword==1` all workers are called, while if `keyword==2` only worker 2 and 3 are called and finally if `keyword==3` only worker
3 is called. This is compared with

```fortran
! if-based selector flow
if (keyword<2) call worker1(keyword)
if (keyword<3) call worker2(keyword)
if (keyword<4) call worker3(keyword)
! block-based selector flow (implies that the order of execution does not matter)
selector: block
  call worker3(keyword) ; if ((keyword==3)) exit selector
  call worker2(keyword) ; if ((keyword>=2)) exit selector
  call worker1(keyword) ;                   exit selector
end block selector
```

In this case the `goto` should actually be advantaged, although the tests performed confirm (again) that the performance are almost identical.

### Run test

Four bash scripts are provided to run the test:

1. `run_gnu.sh`, run the test with GNU gfortran compiler without optimizations;
2. `run_gnu_optimized.sh`, run the test with GNU gfortran compiler with optimizations;
3. `run_gnu.sh`, run the test with Intel Fortran Compiler without optimizations;
4. `run_gnu_optimized.sh`, run the test with Intel Fortran Compiler with optimizations;

### Results obtained

|Compiler              |Optimizations|Architecture                                         | goto      | if        |block      |
|----------------------|-------------|-----------------------------------------------------|-----------|-----------|-----------|
| GNU (6.2.0, 64bit)   | -O3         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.5480^10-4|0.5480^10-4|0.5480^10-4|
| GNU (6.2.0, 64bit)   | -Og         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.7578^10-3|0.7578^10-3|0.7578^10-3|
| Intel (16.0.3, 64bit)| -O3         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.5228^10-4|0.5237^10-4|0.5237^10-4|
| Intel (16.0.3, 64bit)| -O0         |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.9449^10-3|0.9550^10-3|0.9550^10-3|
| GNU (7.0.0, 32bit)   | -??         |Intel Core i5-2400@3.10GHz, 4GB RAM, Windows 64-bit  |0.1357^10-3|0.1356^10-3|0.1356^10-3|
| Intel (17.0.0, 64bit)| -??         |Intel Core i5-2400@3.10GHz, 4GB RAM, Windows 64-bit  |0.4650^10-4|0.4400^10-4|0.4400^10-4|
