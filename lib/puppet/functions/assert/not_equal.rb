# Accepts two parameters that must be of the same type and returns true if both
# parameter values are not equal. Raises Puppet::Error if they are equal.
#
# @example the following are expected to return true
# ~~~ puppet
#   assert::not_equal([1,2,3], {'foo' => 'bar'})
#   'foo'.assert::not_equal('bar')
#   [3,2,1].assert::not_equal(sort([3,2,1]))
# ~~~
#
# @example the following are expected to raise an exception
# ~~~ puppet
#   'foo'.assert::not_equal(foo)
#   true.assert::not_equal(true)
#   assert::not_equal(1,1)
# ~~~
#
# @return [Boolean] only returns true or raises an exception
#
Puppet::Functions.create_function(:'assert::not_equal') do
  dispatch :test do
    param 'Any', :result
    param 'Any', :expected
  end

  def test(result, expected)
    raise Puppet::Error, "assert::not_equal failed because expected result #{expected} equals actual result #{result}" if result == expected
    return true
  end
end
