require 'spec_helper'

describe 'assert::not_equal' do
  it { should run.with_params('not', 'foo').and_return(true) }
  it { should_not run.with_params('same', 'same').and_return(true) }
  it 'raises an exception when false' do
    is_expected.to run.with_params('same', 'same').and_raise_error(Puppet::Error)
  end
end
