# assorted examples of using assert functions

# is_odd is just included here as a toy example
# of something to test
function is_odd(Integer $num) {
  case $num % 2 {
    0: { false }
    default: { true }
  }
}


is_odd(1).assert::true
is_odd(2).assert::false

[1,3,5].each |$x| {
  $x.assert::true |$n| {
    is_odd($n)
  }
}
