# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = "owncloud-berkshelf"

  # Set the version of chef to install using the vagrant-omnibus plugin
  config.omnibus.chef_version = :latest
  base_port = 8090
  %w{ubuntu-12.04 ubuntu-14.04}.each_with_index do |os,i|

    # PORTS:
    # ubuntu-12.04 80 => 8090 443 => 8091
    # ubuntu-14.04 80 => 8092 443 => 8093

    config.vm.define os do |machine|
      machine.vm.box = "opscode_#{os}_chef-provisionerless"
      machine.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_#{os}_chef-provisionerless.box"
      machine.vm.network "forwarded_port", guest: 80, host:base_port + 2*i 
      machine.vm.network "forwarded_port", guest: 443, host:base_port + 2* i + 1 
      machine.vm.provision :chef_solo do |chef|
        chef.json = {
          mysql: {
            server_root_password: 'rootpass',
            server_debian_password: 'debpass',
            server_repl_password: 'replpass'
          },
          owncloud: {
            adminpassword: 'admin',
            mysql: {
              dbpassword: 'owncloud'
            }
          }
        }

        chef.run_list = [
            "recipe[apt]",
            "recipe[owncloud::default]"
        ]
        chef.verbose_logging = true
      end
    end
  end
end
