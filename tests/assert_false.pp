notice('testing assert::false')
assert::false(false)

'foo'.assert::false |$x| {
  $x == 'bar'
}

[].assert::false |$x| {
  'foo' == 'bar'
}
