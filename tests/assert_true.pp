notice('testing assert::true')
assert::true(true)

'foo'.assert::true |$x| {
  $x == 'foo'
}

assert::true(1 + 1 == 2)
assert::false(2 + 2 == 1)
