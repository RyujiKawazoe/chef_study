require 'spec_helper'

describe yumrepo('epel') do  
  it { should exist }
end