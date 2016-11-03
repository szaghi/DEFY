### Array resize with array syntax and LHS automatic-re-allocation has relevant overhead

This test compare the performance of an array resize by means of LHS automatic re-allocation and array syntax copy.

Assuming the task to dynamically resize an array, you could:

+ do the resize on whole array exploiting array syntax;
+ do the resize on chunks of the array, maybe with also the exploitation of `move_alloc` builtin

```fortran
integer, allocatable :: x(:)
integer, allocatable :: tmp(:)
integer              :: i, n

x = [0]
do i=1, 10000
  x = [x, i] ! lhs automatically reallocate and copy rhs by array syntax
end do

! or allocate x by chunks
n = 0
do i=0, 10000
  if (.not.allocated(x)) then
    allocate(x(100))
    n = 1
  else
    if (n==size(x)) then
      allocate(tmp(size(x)+100))
      tmp(1:size(x)) = x ! array syntax
      call move_alloc(tmp, x)
    end if
    n = n + 1
  end if
  x(n) = i
  if (i==10000) then
    if (allocated(tmp)) deallocate(tmp)
    allocate(tmp(n))
    tmp = x(1:n)
    call move_alloc(tmp, x)
  endif
end do
```

### Myth partially demystified

There is a relevant overhead. Indeed, the overhead is not due to array syntax, rather to the whole LHS re-allocation of the first
case. The chunked LHS-realocation is faster due to the lower number or global reallocations: in the first case we `10000`
reallocations in the chunked case we have `10000/100=10` reallocation done by `move_alloc`. Note that also in the second case there
are some *array syntax* statements.

> Array syntax is not evil `per se`, but in conjuction with LHS reallocation can introduce overhead that a *lower level*
> optimization like the chunked resizing can drammatically reduce.

### Run test

Four bash scripts are provided to run the test:

1. `run_gnu.sh`, run the test with GNU gfortran compiler without optimizations;
2. `run_gnu_optimized.sh`, run the test with GNU gfortran compiler with optimizations;
3. `run_gnu.sh`, run the test with Intel Fortran Compiler without optimizations;
4. `run_gnu_optimized.sh`, run the test with Intel Fortran Compiler with optimizations;

### Results obtained

|Compiler (target)    |Optimizations|Architecture                                      |move-alloc |array syntax|
|---------------------|-------------|--------------------------------------------------|-----------|------------|
| GNU 6.2.0 (64bit)   | -O3         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|0.1808^10-1|0.9547^10+1 |
| GNU 6.2.0 (64bit)   | -Og         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|0.4782^10-1|0.1634^10+2 |
| Intel 16.0.3 (64bit)| -O3         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|0.8809^10-2|0.1638^10+1 |
| Intel 16.0.3 (64bit)| -O0         |Intel Core m5-6Y54@1.10GHz, 4GB RAM, x86_64 Ubuntu|0.1637^10+0|0.3276^10+2 |
