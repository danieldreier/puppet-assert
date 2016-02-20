require 'spec_helper'

describe 'assert::false' do
  it { should run.with_params(false).and_return(false) }
  it { should_not run.with_params(true).and_return(true) }
  it { should_not run.with_params(true).and_return(false) }
  it 'raises an exception when true' do
    is_expected.to run.with_params(true).and_raise_error(Puppet::Error)
  end
end
