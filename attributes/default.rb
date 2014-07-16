default['owncloud']['version'] = '6.0.4'
default['owncloud']['download_url'] = "http://download.owncloud.org/community/owncloud-#{default['owncloud']['version']}.tar.bz2"
default['owncloud']['package_sha256_checksum'] = '49b576bf9e7131c08f0437bbbaafdcd900b37010eb90b23048b69dbbb6c01532'
default['owncloud']['server_names'] = %w{owncloud.example.com}
default['owncloud']['document_root'] = '/var/www/owncloud'
default['owncloud']['data_folder'] = '/var/www/owncloud/data'
default['owncloud']['adminlogin'] = 'admin'
default['owncloud']['adminpassword'] = ''
default['owncloud']['max_upload_size'] = '512M'
default['owncloud']['enable_ssl'] = true


