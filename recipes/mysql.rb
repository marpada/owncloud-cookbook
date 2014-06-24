Chef::Application.fatal!("node['owncloud']['mysql']['dbpassword'] cannot be empty") unless node['owncloud']['mysql']['dbpassword'] && node['owncloud']['mysql']['dbpassword'] != '' 

include_recipe "mysql::server"
include_recipe "mysql::client"
include_recipe "database::mysql"

mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database node['owncloud']['mysql']['dbname'] do
  action :create
  connection mysql_connection_info
end

mysql_database_user  node['owncloud']['mysql']['dbuser']  do
    connection    mysql_connection_info
    password   node['owncloud']['mysql']['dbpassword']
    database_name node['owncloud']['mysql']['dbname']
    host        node['owncloud']['mysql']['dbhost']
    privileges    [:all]
    action        :grant
end

template "/root/.my.cnf" do
  owner "root"
  group "root"
  mode "0600"
  source 'my.cnf.erb'
  variables ({
    :dbadmin => 'root',
    :dbpassword => node['mysql']['server_root_password']
  })
end
