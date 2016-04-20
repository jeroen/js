# js

##### *Tools for Working with JavaScript in R*

[![Build Status](https://travis-ci.org/jeroenooms/js.svg?branch=master)](https://travis-ci.org/jeroenooms/js)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/jeroenooms/js?branch=master&svg=true)](https://ci.appveyor.com/project/jeroenooms/js)
[![Coverage Status](https://codecov.io/github/jeroenooms/js/coverage.svg?branch=master)](https://codecov.io/github/jeroenooms/js?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/js)](http://cran.r-project.org/package=js)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/js)](http://cran.r-project.org/web/packages/js/index.html)
[![Github Stars](https://img.shields.io/github/stars/jeroenooms/js.svg?style=social&label=Github)](https://github.com/jeroenooms/js)

> A set of utility functions for working with JavaScript in R.
  Currently includes functions to compile, validate, reformat, optimize
  and analyze JavaScript code.
  
## Documentation

- Vignette: [Working with JavaScript in R](https://cran.r-project.org/web/packages/js/vignettes/intro.html)

## Hello World

Validate some code:

```r
js_validate_script("function foo(x){2*x}") #TRUE
js_validate_script("foo = function(x){2*x}") #TRUE
```

Uglify (reformat and optimize) JavaScript code:

```r
code <- "function test(x, y){ x = x || 1; y = y || 1; return x*y;}"
cat(uglify_optimize(code))
cat(uglify_reformat(code, beautify = TRUE, indent_level = 2))
```

Compile and run coffee script

```r
# Hello world
coffee_compile("square = (x) -> x * x")
coffee_compile("square = (x) -> x * x", bare = TRUE)

# Simple script
demo <- readLines(system.file("example/demo.coffee", package = "js"))
js <- coffee_compile(demo)
cat(js)
cat(uglify_optimize(js))
```

## Installation

Binary packages for __OS-X__ or __Windows__ can be installed directly from CRAN:

```r
install.packages("js")
```

To install on Linux have a look at [V8 installation instructions](https://github.com/jeroenooms/v8#installation).
