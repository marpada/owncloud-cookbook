include_recipe 'nginx'

node.set['nginx']['default_site_enabled'] = false

site_name = node['owncloud']['site_name'] ? node['owncloud']['site_name'] : 'owncloud.localdomain'
server_names = node['owncloud']['server_names'].dup

server_names << site_name unless server_names.include? site_name


# Generate snakeoils certs if enable_ssl but not ssl_certs provided

if node['owncloud']['enable_ssl']
  unless node['owncloud']['ssl_certificate_key'] && node['owncloud']['ssl_certificate']
    package 'ssl-cert'
    execute 'gen_snakeoil-cert' do
      command "/usr/sbin/make-ssl-cert generate-default-snakeoil --force-overwrite"
      creates "/etc/ssl/certs/ssl-cert-snakeoil.pem"
      end
  end
  ssl_certificate = node['owncloud']['ssl_certificate_key'] || "/etc/ssl/certs/ssl-cert-snakeoil.pem"
  ssl_certificate_key = node['owncloud']['ssl_certificate_key'] || '/etc/ssl/private/ssl-cert-snakeoil.key'
end

template "#{node['nginx']['dir']}/sites-available/owncloud" do
    source "nginx.conf.erb"
    mode "0644"
    notifies :reload, "service[nginx]"
    variables(
        server_name: server_names.join(' '),
        hostname: site_name,
        document_root: node['owncloud']['document_root'],
        default_site: true,
        fpm_socket: node['owncloud']['php']['fpm_socket'],
        client_max_body_size: node['owncloud']['max_upload_size'],
        enable_ssl: node['owncloud']['enable_ssl'],
        ssl_certificate: ssl_certificate,
        ssl_certificate_key: ssl_certificate_key,
        fpm_socket: node['owncloud']['php']['fpm_socket']

                  )
end

nginx_site "default.conf" do
  enable false
end
nginx_site "owncloud" do
  enable true
end

