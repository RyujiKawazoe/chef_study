require 'spec_helper'

describe user('vagrant') do
  it { should exist }
  it { should have_home_directory '/home/vagrant' }
end

describe file('/home/vagrant/.rbenv') do
  it { should be_directory }
end

describe file('/home/vagrant/.rbenv/shims/ruby') do
  it { should be_file }
end