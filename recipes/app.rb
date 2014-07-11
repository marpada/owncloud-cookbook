package_name = node['owncloud']['download_url'].split('/')[-1]

remote_file "#{Chef::Config[:file_cache_path]}/#{package_name}" do
  source node['owncloud']['download_url']
  mode 00644
  checksum node['owncloud']['package_sha256_checksum']
  end

include_recipe "libarchive::default"

libarchive_file "#{package_name}" do
   path "#{Chef::Config[:file_cache_path]}/#{package_name}"
   extract_to '/var/www'
   owner node['nginx']['user']
   group node['nginx']['group']
   action :extract
   extract_options [:no_overwrite]
   not_if "grep  #{node['owncloud']['version']} #{node['owncloud']['document_root']}/version.php";

end

template "#{node['owncloud']['document_root']}/config/autoconfig.php" do
  owner "www-data"
  group "www-data"
  mode "0600"
  source "autoconfig.php.erb"
  variables({
         :dbuser => node['owncloud']['mysql']['dbuser'] ,
         :dbname => node['owncloud']['mysql']['dbname'] ,
         :dbpassword => node['owncloud']['mysql']['dbpassword'] ,
         :dbhost => node['owncloud']['mysql']['dbhost'] ,
         :admin => node['owncloud']['adminlogin'] ,
         :admin_password => node['owncloud']['adminpassword'] ,
         :data_directory => node['owncloud']['data_folder'] ,
          })
  not_if "test -f #{node['owncloud']['document_root']}/config/config.php"
  notifies :run, "execute[finish install]", :immediately
end

execute 'finish install' do
 command 'curl http://localhost/'
 action :nothing
 not_if "test -f #{node['owncloud']['document_root']}/config/config.php"
end
