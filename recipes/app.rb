package_name = node['owncloud']['download_url'].split('/')[-1]
config_file = "#{node['owncloud']['document_root']}/config/config.php"

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
  not_if "test -f #{config_file}"
  notifies :run, "execute[finish install]", :immediately
end

execute 'finish install' do
 command 'curl -k -L http://localhost/'
 action :run
 not_if "test -f #{config_file}"
end

if node['owncloud']['disable_trusted_domains'] 
  ruby_block 'authorized_domains' do
    block do 
      config = File.read config_file
      config.gsub!(/'trusted_domains' =>.*array.*\(.*\),+?/m,"")
      File.open('/tmp/config.php.tmp','w') do  |c|
        c << config
      end
      FileUtils.mv('/tmp/config.php.tmp',config_file) if system("php -f /tmp/config.php.tmp")
    end
   only_if "test -f #{config_file} && grep -q trusted_domains #{config_file}"
  end
end

file config_file do
  owner 'www-data'
  group 'www-data'
  mode '0660'
  not_if "test -f #{node['owncloud']['document_root']}/config/autoconfig.php"

end
