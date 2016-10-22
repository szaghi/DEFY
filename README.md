<a name="top"></a>

# DEFY

> dedicated to *FortranFan*(s)

[![License](images/cc.png)]()[![License](images/by.png)]()[Creative Commons Attribution 4.0](http://creativecommons.org/licenses/by/4.0/) license

### DEFY, DEmystify Fortran mYths

A KISS pure Fortran tests collection to hopefully demystify Fortran myths, but probably do not.

- DEFY is a pure Fortran tests collection aimed to demystify common Fortran myths;
- DEFY is aimed to be a highly reproducible Fortran tests collection;
- DEFY is a toy, but...
- DEFY is aimed to teach good practice;
- DEFY is a Free, Open Source Project.

---

| [Copyrights](#copyrights) | [Documentation](#documentation) | [Install](#install) |

---

## Copyrights

[![License](images/cc.png)]()[![License](images/by.png)]()

The content of this project itself is licensed under the [Creative Commons Attribution 4.0](http://creativecommons.org/licenses/by/4.0/) license.

Go to [Top](#top)

## Documentation

DEFY collection is organized by means of subdirectories of `src` home. That is:

```shell
→ tree src/
src/
├── abstraction_has_overhead
│   ├── abstract_ood_1
│   │   ├── defy.f90
│   │   ├── README.md
│   │   ├── run_gnu_optimized.sh
│   │   ├── run_gnu.sh
│   │   ├── run_intel_optimized.sh
│   │   └── run_intel.sh
│   └── README.md
├── goto_is_fastest
│   ├── goto_if_select_comparison_1
│   │   ├── defy.f90
│   │   ├── README.md
│   │   ├── run_gnu_optimized.sh
│   │   ├── run_gnu.sh
│   │   ├── run_intel_optimized.sh
│   │   └── run_intel.sh
│   ├── goto_if_select_comparison_2
│   │   ├── defy.f90
│   │   ├── i.f90
│   │   ├── README.md
│   │   ├── run_gnu_optimized.sh
│   │   ├── run_gnu.sh
│   │   ├── run_intel_optimized.sh
│   │   └── run_intel.sh
│   └── README.md
└── powers_naive_definitions_have_overhead
    ├── powers_1
    │   ├── defy.f90
    │   ├── README.md
    │   ├── run_gnu_optimized.sh
    │   ├── run_gnu.sh
    │   ├── run_intel_optimized.sh
    │   └── run_intel.sh
    └── README.md
...
```

where

+ `src/#myth` is the home of each *myth*, e.g. `src/goto_is_fastest`;
  + each `src/#myth/` contains:
    + `src/#myth/README.md` describes the myth and the *testing suite*;
    + one or more subdirectories containing the actual test(s) where there are:
      + a `README.md` describing the test;
      + a `defy.f90` (or `.F90` is pre-processor directives are used) Fortran file containing the actual test;
      + one or more bash scripts to run the test, e.g. `run_gnu.sh` to run the test with GNU gfortan without optimizations.

Currently DEFY collection includes:

#### [Myths](https://github.com/szaghi/DEFY/tree/master/src)
+ [abstraction has overhead](https://github.com/szaghi/DEFY/tree/master/src/abstraction_has_overhead):
  + [abstract OOD 1](https://github.com/szaghi/DEFY/tree/master/src/abstraction_has_overhead/abstract_ood_1):
+ [goto is fastest](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest):
  + [goto if select comparison 1](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_select_comparison_1);
  + [goto if select comparison 2](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_select_comparison_2);
  + [goto if select comparison 3](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_select_comparison_3);
  + [goto if block comparison 1](https://github.com/szaghi/DEFY/tree/master/src/goto_is_fastest/goto_if_block_comparison_1);
+ [powers naive definitions have overhead](https://github.com/szaghi/DEFY/tree/master/src/powers_naive_definitions_have_overhead):
  + [powers 1](https://github.com/szaghi/DEFY/tree/master/src/powers_naive_definitions_have_overhead/powers_1):
+ any new myth is more than welcome, feel free to open a [new issue](https://github.com/szaghi/DEFY/issues) or create a [pull request](https://github.com/szaghi/DEFY/pulls).

Go to [Top](#top)

## Install

To be written.

Go to [Top](#top)
