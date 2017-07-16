# js

##### *Tools for Working with JavaScript in R*

[![Build Status](https://travis-ci.org/jeroen/js.svg?branch=master)](https://travis-ci.org/jeroen/js)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/jeroen/js?branch=master&svg=true)](https://ci.appveyor.com/project/jeroen/js)
[![Coverage Status](https://codecov.io/github/jeroen/js/coverage.svg?branch=master)](https://codecov.io/github/jeroen/js?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/js)](http://cran.r-project.org/package=js)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/js)](http://cran.r-project.org/web/packages/js/index.html)
[![Github Stars](https://img.shields.io/github/stars/jeroen/js.svg?style=social&label=Github)](https://github.com/jeroen/js)

> A set of utility functions for working with JavaScript in R.
  Currently includes functions to compile, validate, reformat, optimize
  and analyze JavaScript code.
  
## Documentation

- Vignette: [Working with JavaScript in R](https://cran.r-project.org/web/packages/js/vignettes/intro.html)



The js package implements bindings to several popular JavaScript libraries for validating, reformatting, optimizing and analyzing JavaScript code. It builds on the [V8 package](https://cran.r-project.org/package=V8/vignettes/v8_intro.html) (a fully standalone JavaScript engine in R) to call out to these libraries. 

## Syntax Validation

Several R packages allow the user to supply JavaScript code to be used as callback function or configuration object within a visualization or web application. By validating in R that the JavaScript code is syntactically correct and of the right type before actually inserting it in the HTML, we can avoid many annoying bugs. 

The `js_typeof` function simply calls the `typeof` operator on the given code. If the code is invalid, a SyntaxError will be raised.


```r
callback <- 'function test(x, y){ 
  var z = x*y ;
  return z;
}'
js_typeof(callback)
```

```
[1] "function"
```

Same for objects:


```r
conf <- '{
  foo : function (){},
  bar : 123
}'
js_typeof(conf)
```

```
[1] "object"
```

Catch JavaScript typos:


```r
js_typeof('function(x,y){return x + y}}')
```

```
Error in context_eval(join(src), private$context): SyntaxError: Unexpected token }
```

## Script Validation

A JavaScript program typically consists of script with a collection of JavaScript statements. The `js_validate_script` function can be used to validate an entire script. 


```r
jscode <- readLines(system.file("js/uglify.min.js", package="js"), warn = FALSE)
js_validate_script(jscode)
```

```
[1] TRUE
```

Note that JavaScript does not allow for defining anonymous functions in the global scope:


```r
js_validate_script('function(x, y){return x + y}', error = FALSE)
```

```
[1] FALSE
```

To validate individual functions or objects, use the `js_typeof` function. 

## ESprima: Parsing

Esprima is a high performance, standard-compliant ECMAScript parser. It has full support for ECMAScript 2017 and returns a sensible syntax tree format as standardized by ESTree project.



```r
esprima_tokenize(callback)
```

```
         type    value
1     Keyword function
2  Identifier     test
3  Punctuator        (
4  Identifier        x
5  Punctuator        ,
6  Identifier        y
7  Punctuator        )
8  Punctuator        {
9     Keyword      var
10 Identifier        z
11 Punctuator        =
12 Identifier        x
13 Punctuator        *
14 Identifier        y
15 Punctuator        ;
16    Keyword   return
17 Identifier        z
18 Punctuator        ;
19 Punctuator        }
```

```r
esprima_parse(callback)
```

```js
{
  "type": "Program",
  "body": [
    {
      "type": "FunctionDeclaration",
      "id": {
        "type": "Identifier",
        "name": "test"
      },
      "params": [
        {
          "type": "Identifier",
          "name": "x"
        },
        {
          "type": "Identifier",
          "name": "y"
        }
      ],
      "body": {
        "type": "BlockStatement",
        "body": [
          {
            "type": "VariableDeclaration",
            "declarations": [
              {
                "type": "VariableDeclarator",
                "id": {
                  "type": "Identifier",
                  "name": "z"
                },
                "init": {
                  "type": "BinaryExpression",
                  "operator": "*",
                  "left": {
                    "type": "Identifier",
                    "name": "x"
                  },
                  "right": {
                    "type": "Identifier",
                    "name": "y"
                  }
                }
              }
            ],
            "kind": "var"
          },
          {
            "type": "ReturnStatement",
            "argument": {
              "type": "Identifier",
              "name": "z"
            }
          }
        ]
      },
      "generator": false,
      "expression": false,
      "async": false
    }
  ],
  "sourceType": "script"
} 
```

## Compiling CoffeeScript

[CoffeeScript](http://coffeescript.org/) is a little language that compiles into JavaScript. It is an attempt to expose the good parts of JavaScript in a simple way. The `coffee_compile` function binds to the coffee script compiler.


```r
# Hello world
cat(coffee_compile("square = (x) -> x * x"))
```

```js
(function() {
  var square;

  square = function(x) {
    return x * x;
  };

}).call(this);
```

```r
cat(coffee_compile("square = (x) -> x * x", bare = TRUE))
```

```
var square;

square = function(x) {
  return x * x;
};
```


The golden rule of CoffeeScript is: *"It's just JavaScript"*. The code compiles one-to-one into the equivalent JS, and there is no interpretation at runtime. You can use any existing JavaScript library seamlessly from CoffeeScript (and vice-versa). The compiled output is readable and pretty-printed, will work in every JavaScript runtime, and tends to run as fast or faster than the equivalent handwritten JavaScript.


```r
# Simple script
demo <- readLines(system.file("example/demo.coffee", package = "js"))
cat(demo, sep = "\n")
```

```
# Assignment:
number   = 42
opposite = true

# Conditions:
number = -42 if opposite

# Functions:
square = (x) -> x * x

# Arrays:
list = [1, 2, 3, 4, 5]

# Objects:
math =
  root:   Math.sqrt
  square: square
  cube:   (x) -> x * square x

# Splats:
race = (winner, runners...) ->
  print winner, runners

# Existence:
alert "I knew it!" if elvis?

# Array comprehensions:
cubes = (math.cube num for num in list)
```

```r
js <- coffee_compile(demo)
cat(js)
```

```js
(function() {
  var cubes, list, math, num, number, opposite, race, square,
    slice = [].slice;

  number = 42;

  opposite = true;

  if (opposite) {
    number = -42;
  }

  square = function(x) {
    return x * x;
  };

  list = [1, 2, 3, 4, 5];

  math = {
    root: Math.sqrt,
    square: square,
    cube: function(x) {
      return x * square(x);
    }
  };

  race = function() {
    var runners, winner;
    winner = arguments[0], runners = 2 <= arguments.length ? slice.call(arguments, 1) : [];
    return print(winner, runners);
  };

  if (typeof elvis !== "undefined" && elvis !== null) {
    alert("I knew it!");
  }

  cubes = (function() {
    var i, len, results;
    results = [];
    for (i = 0, len = list.length; i < len; i++) {
      num = list[i];
      results.push(math.cube(num));
    }
    return results;
  })();

}).call(this);
```

```r
cat(uglify_optimize(js))
```

```
(function(){var cubes,list,math,num,number,opposite,race,square,slice=[].slice;number=42,opposite=!0,opposite&&(number=-42),square=function(x){return x*x},list=[1,2,3,4,5],math={root:Math.sqrt,square:square,cube:function(x){return x*square(x)}},race=function(){var runners,winner;return winner=arguments[0],runners=2<=arguments.length?slice.call(arguments,1):[],print(winner,runners)},"undefined"!=typeof elvis&&null!==elvis&&alert("I knew it!"),cubes=function(){var i,len,results;for(results=[],i=0,len=list.length;len>i;i++)num=list[i],results.push(math.cube(num));return results}()}).call(this);
```


## Uglify: reformatting

One of the most popular and powerful libraries for working with JavaScript code is [uglify-js](https://www.npmjs.com/package/uglify-js). Uglify provides an extensive toolkit for manipulating the syntax tree of a piece of JavaScript code.

The `uglify_reformat` binding parses a string with code and then feeds it to the [uglify code generator](http://lisperator.net/uglifyjs/codegen) which converts it back to JavaScript text, with custom formatting options. This is nice for fixing whitespace, semicolons, etc.


```r
code <- "function test(x, y){ x = x || 1; y = y || 1; return x*y;}"
cat(uglify_reformat(code, beautify = TRUE, indent_level = 2))
```

```js
function test(x, y) {
  x = x || 1;
  y = y || 1;
  return x * y;
}
```

## Uglify: optimization

The more impressive part of uglify-js is the [compressor](http://lisperator.net/uglifyjs/compress) which refactors the entire syntax tree, effectively rewriting your code into a more compact but equivalent program. The `uglify_optimize` function in R is a simple wrapper which parses code and then feeds it to the compressor.


```r
cat(code)
```

```
function test(x, y){ x = x || 1; y = y || 1; return x*y;}
```

```r
cat(uglify_optimize(code))
```

```js
function test(x,y){return x=x||1,y=y||1,x*y}
```

You can pass [compressor options](http://lisperator.net/uglifyjs/compress) to `uglify_optimize` to control the various uglify optimization techniques.

## JSHint: code analysis

JSHint will automatically detect errors and potential problems in JavaScript code. The `jshint` function is R will return a data frame where each row is a problem detected by the library (type, line and reason of error): 


```r
code <- "var foo = 123"
jshint(code)
```

```
       id                raw code      evidence line character  scope             reason
1 (error) Missing semicolon. W033 var foo = 123    1        14 (main) Missing semicolon.
```

JSHint has many [configuration options](http://jshint.com/docs/options/) to control which types of code propblems it will report on.
