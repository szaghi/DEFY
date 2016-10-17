### Abstraction has relevant overhead

> The usage of abstract types (abstract OOD) **involves relevant overhead** with respect an equivalent non abstract implementation.

### Not completely demystified

The tests provides seem to confirm the existence of relevant overhead in some circumstances:

+ for Intel Fortran compiler the tests reveal:
  + the abstract OOD type is 20% **slower** with respect the non abstract OOD when optimizations are enabled;
  + the abstract OOD type is 30% **faster** with respect the non abstract OOD without optimizations;
+ for GNU gfortran compiler the tests reveal:
  + the abstract OOD type is 14% **slower** with respect the non abstract OOD when optimizations are enabled;
  + the abstract OOD type is 5% **faster** with respect the non abstract OOD without optimizations;

It seems that the non abstract OOD type is more likely optimizable than the abstract equivalent.

### DEFY Tests

DEFY provides the following tests for this myth demystification:
+ [abstract OOD 1](https://github.com/szaghi/DEFY/tree/master/src/abstraction_has_overhead/abstract_ood_1);

See their README.md to see the results obtained.
