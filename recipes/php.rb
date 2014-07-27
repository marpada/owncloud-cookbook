include_recipe 'php'
include_recipe 'php-fpm'

php_fpm_pool "www" do
    enable false
end

php_options = ''

node['owncloud']['php']['options'].each do |k,v|
  php_options << "php_admin_value[#{k}] => '#{v}', "
end

pool_php_options = {}

node['owncloud']['php']['options'].each do |k,v|
  pool_php_options["php_admin_value[#{k}]"] = v
end


php_fpm_pool "owncloud" do
    process_manager node['owncloud']['php']['process_manager']
    listen  node['owncloud']['php']['fpm_socket']
    max_children  node['owncloud']['php']['max_children']
    min_spare_servers  node['owncloud']['php']['min_spare_servers']
    max_spare_servers  node['owncloud']['php']['max_spare_servers']
    php_options pool_php_options
end

## Install and configure required php-modules
%w{mcrypt gd mysql curl imap xcache imagick mhash }.each do |m|
  package "php5-#{m}" do
    action :install
  end

    execute "enable php5-#{m}" do
      command "php5enmod #{m}"
      only_if "which php5enmod"
    end
  #end
end


# Smelly code but couldn't figure out a way to find the proper
# location of php config dir during run time.
if node['owncloud']['php']['xcache_enabled']
  template "/etc/php5/conf.d/xcache.ini" do
    owner 'root'
    group 'root'
    mode '0644'
    source 'xcache.ini.erb'
    variables ({ :xcache => node['owncloud']['php']['xcache'],
                 :xcache_admin => node['owncloud']['php']['xcache_admin'],
    })
    notifies :reload, "service[php-fpm]"
    only_if "test -d /etc/php5/conf.d"
  end
  template "/etc/php5/mods-available/xcache.ini" do
    owner 'root'
    group 'root'
    mode '0644'
    source 'xcache.ini.erb'
    variables ({ :xcache => node['owncloud']['php']['xcache'],
                 :xcache_admin => node['owncloud']['php']['xcache_admin'],
    })
    notifies :reload, "service[php-fpm]"
    only_if "test -d /etc/php5/mods-available"
  end
else
  file "/etc/php5/conf.d/xcache.ini" do
    action :delete
  end
  file "/etc/php5/mods-available/xcache.ini" do
    action :delete
  end
end
