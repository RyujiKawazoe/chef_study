require 'spec_helper'

describe package('git'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end