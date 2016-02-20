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
