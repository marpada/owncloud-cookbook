default['owncloud']['php']['fpm_socket'] = '/var/run/fpm-owncloud.sock'
default['owncloud']['php']['process_manager'] = 'dynamic'
default['owncloud']['php']['max_children'] = '10'
default['owncloud']['php']['mim_spare_servers'] = '2'
default['owncloud']['php']['max_spare_servers'] = '5'
default['owncloud']['php']['options'] = {}
default['owncloud']['php']['options']['upload_max_filesize'] = node['owncloud']['max_upload_size'] || "512M"
default['owncloud']['php']['options']['post_max_size'] = node['owncloud']['max_upload_size'] || "512M"
default['owncloud']['php']['options']['max_execution_time'] = node['owncloud']['timeout']

## XCACHE extension settings.
#
default['owncloud']['php']['xcache_enabled'] = true
default['owncloud']['php']['xcache'] = {}
default['owncloud']['php']['xcache_admin'] = {}
default['owncloud']['php']['xcache']['shm_scheme'] = %q{"mmap"}
default['owncloud']['php']['xcache']['shm_size'] = "16M"
default['owncloud']['php']['xcache']['optimizer'] = "On"
default['owncloud']['php']['xcache']['count'] = node['cpu']['total']
default['owncloud']['php']['xcache']['slots'] = '8K'
default['owncloud']['php']['xcache']['ttl'] = '0'
# XCACHE Admin
default['owncloud']['php']['xcache_admin']['enable_auth'] = 'Off'
default['owncloud']['php']['xcache_admin']['user'] = %q{"m0o"}
default['owncloud']['php']['xcache_admin']['pass'] = %q{""}
