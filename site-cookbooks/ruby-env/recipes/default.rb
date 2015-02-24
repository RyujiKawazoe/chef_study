#
# Cookbook Name:: ruby-env
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{git openssl-devel sqlite-devel gcc zlib zlib-devel openssl libffi-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

git "/home/#{node['ruby-env']['user']}/.rbenv" do
  repository node["ruby-env"]["rbenv_url"]
  reference node['ruby-env']['rbenv']['branch']
  action :sync
  user node['ruby-env']['user']
  group node['ruby-env']['group']
end

template ".bash_profile" do
  source ".bash_profile.erb"
  path "/home/#{node['ruby-env']['user']}/.bash_profile"
  mode 0644
  owner node['ruby-env']['user']
  group node['ruby-env']['group']
  not_if "grep rbenv ~/.bash_profile", :environment => { :'HOME' => "/home/#{node['ruby-env']['user']}" }
end

directory "/home/#{node['ruby-env']['user']}/.rbenv/plugins" do
  owner node['ruby-env']['user']
  group node['ruby-env']['group']
  mode 0755
  action :create
end

git "/home/#{node['ruby-env']['user']}/.rbenv/plugins/ruby-build" do
  repository node["ruby-env"]["ruby-build_url"]
  reference node['ruby-env']['ruby-build']['branch']
  action :sync
  user node["ruby-env"]["user"]
  group node["ruby-env"]["group"]
end

git "/home/#{node['ruby-env']['user']}/.rbenv/plugins/rbenv-gem-rehash" do
  repository node['ruby-env']['rbenv-gem-rehash_url']
  action :sync
  user node["ruby-env"]["user"]
  group node["ruby-env"]["group"]
end

execute "rbenv install #{node['ruby-env']['version']}" do
  command "/home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv install #{node['ruby-env']['version']}"
  user node['ruby-env']['user']
  group node["ruby-env"]["group"]
  environment 'HOME' => "/home/#{node['ruby-env']['user']}"
  not_if { File.exist?("/home/#{node['ruby-env']['user']}/.rbenv/versions/#{node['ruby-env']['version']}")}
end

execute "rbenv global #{node['ruby-env']['version']}" do
  command "/home/#{node['ruby-env']['user']}/.rbenv/bin/rbenv global #{node['ruby-env']['version']}"
  user node['ruby-env']['user']
  group node["ruby-env"]["group"]
  environment 'HOME' => "/home/#{node['ruby-env']['user']}"
end

%w{rbenv-rehash bundler}.each do |target|
  execute "gem install #{target}" do
    command "/home/#{node['ruby-env']['user']}/.rbenv/shims/gem install #{target}"
    user node['ruby-env']['user']
    group node["ruby-env"]["group"]
    environment 'HOME' => "/home/#{node['ruby-env']['user']}"
    not_if "/home/#{node['ruby-env']['user']}/.rbenv/shims/gem list | grep #{target}"
  end
end
