### (Naive) definitions of powers (elevation) could have relevant overhead

> A lazy (naive) definition of power elevations can generate relevant overhead degrading the computational speed.

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

### Not demystified

> The *myth* is confirmed (not demystified), but overheads are somehow less than expected.

### DEFY Tests

DEFY provides the following tests for this myth demystification:
+ [powers 1](https://github.com/szaghi/DEFY/tree/master/src/powers_naive_definitions_have_overhead/powers_1);

See their README.md to see the results obtained.
