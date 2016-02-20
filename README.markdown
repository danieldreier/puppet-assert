#### Puppet Assert Functions
[![Build Status](https://travis-ci.org/danieldreier/puppet-assert.svg?branch=master)](https://travis-ci.org/danieldreier/puppet-assert)

1. [Overview](#overview)
2. [Description](#description)
3. [Getting Started](#getting-started)
4. [Usage](#usage)
5. [Development](#development)

## Overview

Puppet functions to make assertions that fail the compile if they're not met.

## Description

This module provides several functions intended for testing other puppet functions. If you're writing puppet functions without side effects, this is a simpler way to write tests than using rspec-puppet. The intent is to provide what amounts to syntactic sugar for writing simple tests in Puppet.

### Getting Started

To get started, you can test simple puppet expressions. Put the following in a file and run it using `puppet apply`:

```puppet
assert::true(true)
assert::true(1 + 1 == 2)
assert::false(false)
assert::false(2 + 2 == 1)
```

This will run without errors, or any output at all:
```shell
puppet apply test.pp
Notice: Compiled catalog for macbook in environment production in 0.03 seconds
Notice: Applied catalog in 0.01 seconds
```

Change one of the assertions so that it fails:
```puppet
assert:true(false)
```

```shell
puppet apply test.pp
Error: Evaluation Error: Error while evaluating a Function Call, assert::true failed because argument is false instead of true at /tmp/example.pp:1:1 on node macbook
```

A trivial test of custom function would look something like:
```puppet
# our custom function
function is_odd($num) {
  case $num % 2 {
    0: { false }
    default: { true }
  }
}

# using dot notation
is_odd(1).assert::true
is_odd(2).assert::false

# passing values to a block
[1,3,5].each |$x| {
  $x.assert::true |$n| {
    is_odd($n)
  }
}
```


## Usage

### assert::equal(Any, Any)
Return true if both parameters are equal, or return an error if the values are not equal.

**example**: using `assert::equal`:
```puppet
assert::equal('example', 'example')
'example'.assert::equal('example')
assert::equal((2 + 2),4)
```

### assert::not_equal(Any, Any)
Return true if both parameters are not equal, and return an error if the values are equal.

**example**: using `assert::not_equal`:
```puppet
assert::not_equal(1, 2)
assert::not_equal(true, false)
true.assert::not_equal(false)
'fizz'.assert::not_equal('buzz')
```

### assert::true
If given a single boolean parameter, `assert::true` will raise an error if the parameter value is false, and will return true if the parameter value is true.

**example**: using `assert::true` with a boolean parameter:
```puppet
assert::true(2 + 2 == 4)
```

Given a block and any number of parameters, `assert::true` will raise an error if the block returns any value other than a Boolean true value.

**example**: using `assert::true` with a block:
```puppet
'hunter2'.assert::true |$amazing_password| {
  $amazing_password =~ /[\w]+/
}
```

### assert::false
`assert::false` is the inverse of `assert::true`.
**example**: using `assert::false` with a boolean parameter:
```puppet
assert::false(1 + 1 == 3)
```

**example**: using `assert::false` with a block:
```puppet
'daniel'.assert::false |$username| {
  $username == 'joe'
}
```


## Development

Please contribute if there's functionality you'd like to see, and please file issues if you run into problems. Testing inside the puppet language isn't much of a thing, so the tooling around it is minimal.

The goal for this particular module is to provide a very simple way to test functions based on assertions, because I want to write more puppet functions and I enjoy writing puppet more than writing rspec-puppet.

More sophisticated in-language testing tools may be needed, so the goal here is to have something simple that can bootstrap a larger ecosystem of functional puppet tools.
