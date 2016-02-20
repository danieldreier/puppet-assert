# When given one parameter, returns false if the parameter is a boolean false,
# or raise a Puppet::Error if the parameter is true.
#
# When the parameter is a boolean value, `assert::false` either returns false or
# raises a `Puppet::Error` if the parameter is not a boolean false.
#
# @example expected to pass
# ~~~ puppet
#   ([1,2,3].sort == [3,2,1]).assert::false
# ~~~
#
# @example expected to raise an exception
# ~~~ puppet
#   assert::false(1 + 1 == 2)
# ~~~
#
# When a lambda and any number of parameters are provided it passes all
# parameters to the block and validates that the block returns boolean false.
# It returns false if the block returned false, or raises a Puppet::Error if the
# block returns anything other than boolean false.
#
# @example lambda expected to return false
# ~~~ puppet
#   [1,2,3]).assert::false |$x| {
#     sort($x) == [3,2,1]
#   }
# ~~~
#
Puppet::Functions.create_function(:'assert::false') do
  dispatch :assert do
    param 'Boolean', :arg
  end

  dispatch :assert_block do
    repeated_param 'Any', :arg
    block_param
  end

  def assert(arg)
    raise Puppet::Error, "assert::false failed because argument is #{arg} instead of false" unless arg == false
    return false if arg == false
  end

  def assert_block(*args)
    output = yield(*args)
    raise Puppet::Error, "assert::false failed because the block's return value is #{output} instead of false" unless output == false
    return false if output == false
  end
end
