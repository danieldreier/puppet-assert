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
    raise Puppet::Error, "assert::true failed because the block's return value is #{output} instead of false" unless output == false
    return false if output == false
  end
end
