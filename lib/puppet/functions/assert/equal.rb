# Accepts two parameters that must be of the same type and returns true if both
# parameters are equal, or raises a Puppet::Error if they are not equal.
#
# @example expected to pass
# ~~~ puppet
#   assert::equal([1,2,3], [1,2,3])
#   'foo'.assert::equal('foo')
#   [1,2,3].assert::equal(sort([3,2,1]))
# ~~~
#
# @example expected to raise an exception
# ~~~ puppet
#   'foo'.assert::equal(bar)
#   'true'.assert::equal(true)
#   assert::equal(1,2)
# ~~~
#
# @return [Boolean] only returns true or raises an exception
Puppet::Functions.create_function(:'assert::equal') do
  dispatch :test do
    param 'Any', :result
    param 'Any', :expected
  end

  def test(result, expected)
    raise Puppet::Error, "expected result #{expected} does not equal actual result #{result}" unless result == expected
    return true
  end
end
