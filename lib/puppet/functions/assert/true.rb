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
