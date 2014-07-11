default['owncloud']['php']['fpm_socket'] = '/var/run/fpm-owncloud.sock'
default['owncloud']['php']['process_manager'] = 'dynamic'
default['owncloud']['php']['max_children'] = '10'
default['owncloud']['php']['mim_spare_servers'] = '2'
default['owncloud']['php']['max_spare_servers'] = '5'
default['owncloud']['php']['options'] = {}
default['owncloud']['php']['options']['upload_max_filesize'] = node['owncloud']['max_upload_size'] || "512M"
default['owncloud']['php']['options']['post_max_size'] = node['owncloud']['max_upload_size'] || "512M"
default['owncloud']['php']['options']['max_execution_time'] = 18000
