### Goto-if elseif-select case performance comparison, test 1

This test compare (computed) `goto` with `if` branching-flow construct. The selector for the branching-jump is computed pseudo-randomically and the *work* done inside the *workers* called by each branch is not uniform.

This is a modification of [goto-if elseif-select case](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_select_comparison_1) test proposed by Ron Shepard (select case is not considered into this test, rather the `block` construct). Essentially, the branching-flow is now *flushed*: the selector selects *from which keyword* start to call the workers and call not only the worker corresponding to that keyword, but also all subsequent workers, e.g.

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

In this case the `goto` should actually be advantaged, although the tests performed confirm again that the performance are almost identical.

### Run test

Four bash scripts are provided to run the test:

1. `run_gnu.sh`, run the test with GNU gfortran compiler without optimizations;
2. `run_gnu_optimized.sh`, run the test with GNU gfortran compiler with optimizations;
3. `run_gnu.sh`, run the test with Intel Fortran Compiler without optimizations;
4. `run_gnu_optimized.sh`, run the test with Intel Fortran Compiler with optimizations;

### Results obtained

|Compiler|Optimizations|Architecture                                         | goto      | if        |block      |
|--------|-------------|-----------------------------------------------------|-----------|-----------|-----------|
| GNU    |   yes       |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.5480^10-4|0.5480^10-4|0.5480^10-4|
| GNU    |   no        |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.7578^10-3|0.7578^10-3|0.7578^10-3|
| Intel  |   yes       |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.5228^10-4|0.5237^10-4|0.5237^10-4|
| Intel  |   no        |Intel Xeon X5650@2.67GHz, 24GB RAM, x86_64 Arch Linux|0.9449^10-3|0.9550^10-3|0.9550^10-3|
