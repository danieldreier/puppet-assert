require 'spec_helper'

describe 'assert::equal' do
  it { should run.with_params('foo', 'foo').and_return(true) }
  it { should_not run.with_params('foo', 'bar').and_return(true) }
  it 'raises an exception when false' do
    is_expected.to run.with_params('fizz', 'buzz').and_raise_error(Puppet::Error)
  end
end
