#
# Cookbook Name:: owncloud
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apt"
include_recipe "mysql::server"
include_recipe "mysql::client"
include_recipe "nginx::source"

node.set['php']['install_method'] = 'dotdeb'
include_recipe 'php::dotdeb'
include_recipe 'php::fpm'

remote_file '/var/tmp/' do
  source node['owncloud']['download_url']
  mode 00644
  checksum node['owncloud']['package_sha256_checksum']
  end


