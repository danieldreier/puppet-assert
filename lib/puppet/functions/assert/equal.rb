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
