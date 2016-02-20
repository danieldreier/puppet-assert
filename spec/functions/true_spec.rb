require 'spec_helper'

# I don't know how to test functions that accept
# blocks using rspec-puppet, so that's just not tested for now
describe 'assert::true' do
  it { should run.with_params(true).and_return(true) }
  it { should_not run.with_params(false).and_return(true) }
  it 'raises an exception when false' do
    is_expected.to run.with_params(false).and_raise_error(Puppet::Error)
  end
end
