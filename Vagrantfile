# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  require 'vagrant-vbguest' unless defined? config.vbguest
  config.vbguest.auto_update = true

  p ENV["http_proxy"]
  p ENV["https_proxy"]
  
  config.proxy.http     = ENV["http_proxy"]
  config.proxy.https    = ENV["https_proxy"]

  config.vm.hostname = "develop2015"
  config.vm.box = "develop_2015_by_chef"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.6_chef-provisionerless.box"

  config.vm.network :private_network, ip: "192.168.3.27"

  # vagrant plugin install vagrant-omnibusが必要
  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["./cookbooks", "./site-cookbooks"]
    chef.run_list = %w[
      recipe[yum-epel]
      recipe[nginx]
      recipe[git]
      recipe[ruby-env]
      recipe[timezone]
    ]
  end
end
