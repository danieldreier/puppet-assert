# When given one parameter, returns true if the parameter is a boolean true,
# or raise a Puppet::Error if the parameter is false.
#
#
# When the parameter is a boolean value, `assert::true` either returns true or
# raises a `Puppet::Error` if the parameter is not a boolean true.
#
# @example expected to succeed
# ~~~ puppet
#   ([1,3,2].sort == [1,2,3]).assert::true
# ~~~
#
# @example expected to raise an exception
# ~~~ puppet
#   assert::true(2 + 2 == 1)
# ~~~
#
# When a lambda and any number of parameters are provided it passes all
# parameters to the block and validates that the block returns boolean true.
# It returns true if the block returned true, or raises a Puppet::Error if the
# block returns anything other than boolean true.
#
# @example lambda expected to return true
# ~~~ puppet
#   [1,3,2]).assert::true |$x| {
#     sort($x) == [1,2,3]
#   }
# ~~~
#
Puppet::Functions.create_function(:'assert::true') do
  dispatch :assert do
    param 'Boolean', :arg
  end

  dispatch :assert_block do
    repeated_param 'Any', :arg
    block_param
  end

  def assert(arg)
    raise Puppet::Error, "assert::true failed because argument is #{arg} instead of true" unless arg == true
    return true if arg == true
  end

  def assert_block(*args)
    output = yield(*args)
    raise Puppet::Error, "assert::true failed because the block's return value is #{output} instead of true" unless output == true
    return true if output == true
  end
end
