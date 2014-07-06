include_recipe 'php'
include_recipe 'php::fpm'


  php_fpm 'owncloud' do
    action :add
    socket true
    user node['nginx']['user']
    group node['nginx']['group']
    socket_path "/var/run/owncloud.sock"
    start_servers 1
    max_children node['owncloud']['fpm']['max_children']
    min_spare_servers 1
    max_spare_servers 1
  value_overrides({
  :error_log => "#{node['php']['fpm_log_dir']}/owncloud.log"
  })
  end

%w{curl gd mbstring mcrypt memcache mhash mysql xml apc}.each do |m|
  include_recipe "php::module_#{m}"
end


%w{php5-imagick }.each do |p|
  package p do
    action :install
  end
end
