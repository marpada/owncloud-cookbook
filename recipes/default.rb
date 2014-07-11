#
# Cookbook Name:: owncloud
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
Chef::Application.fatal!("node['owncloud']['adminpassword'] cannot be empty") unless node['owncloud']['adminpassword'] && node['owncloud']['adminpassword'] != '' 

include_recipe "apt"
include_recipe "owncloud::requirements"
include_recipe "owncloud::php"
include_recipe "owncloud::mysql"
include_recipe "owncloud::nginx"
include_recipe "owncloud::app"
