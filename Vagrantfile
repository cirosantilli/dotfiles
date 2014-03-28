# -*- mode: ruby -*-
# vi: set ft=ruby :

# Minimalistic template containing with the most important settings.

# WARNING: if you use more than one CPU on the guest
# enable hardware virtualization from your BIOS
cpus = '1'
memory = '512'

hostname = 'dotfiles'

Vagrant.configure("2") do |config|
  # WARNING: if you are going to run a 64 bit guest inside a 32 bit host
  # you must enable hardware virtualization from your BIOS
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.hostname = hostname
  config.vm.network :forwarded_port, guest: 4000, host: 4000
  config.vm.provider "virtualbox" do |v|
    v.customize [
      'modifyvm', :id,
      '--cpus', cpus,
      '--memory', memory,
      '--name', hostname + '_vagrant'
    ]
    if cpus.to_i > 1
      v.customize ["modifyvm", :id, "--ioapic", "on"]
    end
  end
  config.vm.provision :shell, privileged: false, path: 'test-provision.sh'
end
