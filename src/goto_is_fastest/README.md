### (Computed) GOTO is fastest (than all)

> (Computed) GOTO is fastest (than all other branching-flow models) because **it is usually compiled as a faster selection**.

#### Myth example

The myth states that for a genric (possible randomic) select value, the `goto`-based branching-flow

```fortran
goto (10, 20, 30), selector
goto 40
10 call worker1
goto 40
20 call worker2
goto 40
30 call worker3
goto 40
40 continue
```

is compiled into a **faster** selector than

```fortran
select case(selector)
case(1)
  call worker1
case(2)
  call worker2
case(3)
  call worker3
end select

! or

if (selector==1) then
  call worker1
elseif (selector==2)
  call worker2
elseif (selector==3)
  call worker3
end if
```

The myth originates from the old-good days when other branching-flow models (e.g. `if elseif` and `select case`) were added to the language (the early Fortran 90 implementations) alongside `goto`: *probably* the early compilers implementations supporting the *new* (for those days) branching models were not able to optimized the compiled selection based on that models as well as they did for the very-well supported (computed) `goto` model.

#### Variants

The simple branching-flow afore described is analyzed for also some variants:

+ *flushed* branching-flow: the selector is used to find only the first worker to call, but also all other subsequent workers are called; this is intended to flavor `goto` that follow this bias without the need of *nested checks*;
+ *probability-ordered* branching-flow: the selector values are (pre) ordered into a list from the most probable (to be called) selector value to the most improbable; this is intended to help the optimizer to guess (e.g. pre-fetching) the next most probable branch.

### Demystified

Nowadays, the most part of mainstream compiler vendors (e.g. Intel Fortran Compiler and GNU gfortran) do a very good work concerning the optimization of the *new* branching models.

> (computed) `goto` selector-based **has the same** performance of equivalent `select case` or `if elseif` branching-flow models, there **is not** any observable speedup.

The presupposed `goto` higher performance is a **myth** nowadays. Moreover, `goto` is now an *obsolescent* feature of Fortran and it *should* be avoided (in new codes) for many good reasons among which we recall:

+ `goto` is known to be *error-prone*;
+ `goto` is known to be *spaghetti-code-prone*;
+ `goto` is known to generate unreadable code;
+ `goto` is known to generate unmaintainable code;
+ `goto` prevents multi-threading exploitation, namely a big issue when *peformance is an imperative goal*;
+ `goto` is much more limited than `select case` and `if elseif` constructs:
  + `select case` helps in writing clear code that should be easier to understand and maintain;
  + `select case` works with integer, logical, and character scalar expressions whereas computed `goto` only uses scalar numeric expressions that may be converted to integer type, thus needing some extra actions for the conversion.

### DEFY Tests

DEFY provides the following tests for this myth demystification:
+ [goto if select comparison 1](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_select_comparison_1): the baseline test;
+ [goto if select comparison 2](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_select_comparison_2): a variant of the baseline test proposed by FortranFan;
+ [goto if select comparison 3](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_select_comparison_3): the baseline variation using pre-ordered most-probable selector values list;
+ [goto if select comparison 4](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_select_comparison_4): the baseline variation using 20 branches conditions instead of only 4;
+ [goto if block comparison 1](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_block_comparison_1): the baseline variation with *flushed flow* bias.

See their README.md to see the results obtained.
