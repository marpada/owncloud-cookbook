default['owncloud']['version'] = '6.0.3'
default['owncloud']['download_url'] = "http://download.owncloud.org/community/owncloud-#{default['owncloud']['version']}.tar.bz2"
default['owncloud']['package_sha256_checksum'] = '422b831ed5892ce20642a75130eb7ac755c678b798675778d857319c1afbc28a'
default['owncloud']['server_names'] = %w{owncloud.example.com}
default['owncloud']['document_root'] = '/var/www/owncloud'
default['owncloud']['data_folder'] = '/var/www/owncloud/data'
#default['owncloud']['data_folder'] = "#{node['owncloud']['document_root']}/data"
default['owncloud']['adminlogin'] = 'admin'
default['owncloud']['adminpassword'] = ''

