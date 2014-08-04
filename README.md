# owncloud-cookbook

ownCloud (owncloud.org)  is open source file sync and share software for
everyone from individuals operating the free ownCloud Community Edition,
to large enterprises and service providers operating the ownCloud
Enterprise Edition. ownCloud provides a safe, secure, and compliant file
synchronization and sharing solution on servers that you control

This cookbook automates the installation and initial setup of Owncloud
of a single node deployment using the following stack:

* Ubuntu 12.04 / 14.04
* nginx
* MySQL server
* PHP-FPM

## Supported Platforms

Ubuntu 12.04 and 14.04. Might work on other Debian-based distros.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['owncloud']['version']</tt></td>
    <td>string</td>
    <td>Owncloud version</td>
    <td>/td>
  </tr>
  <tr>
    <td><tt>['owncloud']['download_url']</tt></td>
    <td>string</td>
    <td>URL to download the owncloud tarball</td>
    <td>/td>
  </tr>
  <tr>
    <td><tt>['owncloud']['package_sha256_checksum']</tt></td>
    <td>string</td>
    <td>tarball's sha256 checksum </td>
    <td>/td>
  </tr>
  <tr>
    <td><tt>['owncloud']['server_names']</tt></td>
    <td>Array</td>
    <td>fqdn for owncloud</td>
    <td>['owncloud.example.com']</td>
    <td>/td>
  </tr>
  <tr>
    <td><tt>['owncloud']['document_root']</tt></td>
    <td>String</td>
    <td>Path for the vhost document folder</td>
    <td>/var/www/owncloud</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['data_folder']</tt></td>
    <td>String</td>
    <td>Path for the data folder (can be outside the web folder for
security reasons</td>
    <td>/var/www/owncloud/data</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['admin_login']</tt></td>
    <td>String</td>
    <td>Handle for the owncloud admin user</td>
    <td>admin</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['adminpassword']</tt></td>
    <td>String</td>
    <td>Password for the owncloud admin user</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['owncloud']['max_upload_size']</tt></td>
    <td>String</td>
    <td>Maximum size for uploaded files</td>
    <td>512M</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['timeout']</tt></td>
    <td>String</td>
    <td>Timeout for preventing long running operations from failing
(seconds)</td>
    <td>1800</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['disable_trusted_domains']</tt></td>
    <td>Boolean</td>
    <td>Disable owncloud's default restriction for connecting only
whitelisted domains.</td>
    <td>true</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['enable_ssl']</tt></td>
    <td>Boolean</td>
    <td>Whether to enable and enforce https connections (using snakeoil
self-signed certificates if certs not providers</td>
    <td>true</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['ssl_certificate_key']</tt></td>
    <td>String</td>
    <td>Path of the domain's SSL private key </td>
    <td>nil</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['ssl_certificate']</tt></td>
    <td>String</td>
    <td>Path of the domain's SSL certificate </td>
    <td>nil</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['mysql']['dbname']</tt></td>
    <td>String</td>
    <td>MySQL database name</td>
    <td>owncloud</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['mysql']['dbuser']</tt></td>
    <td>String</td>
    <td>MySQL database user</td>
    <td>owncloud</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['mysql']['dbpassword']</tt></td>
    <td>String</td>
    <td>MySQL database password</td>
    <td>owncloud</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['mysql']['dbhost']</tt></td>
    <td>String</td>
    <td>MySQL server address</td>
    <td>127.0.0.1</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['php']['process_manager']</tt></td>
    <td>String</td>
    <td>PHP-FPM process spawning strategy</td>
    <td>dynamic</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['php']['max_children']</tt></td>
    <td>String</td>
    <td>Max PHP workers</td>
    <td>10</td>
  </tr>
  <tr>
    <td><tt>['owncloud']['php']['options']</tt></td>
    <td>Hash</td>
    <td>Key-Value dictionary with PHP options for the PHP-FPM pool</td>
    <td></td>
  </tr>
</table>

## Usage

### owncloud::default

Include `owncloud` in your node's `run_list`. At least provide values for
node['owncloud']['adminpassword'], node['owncloud']['mysql']['dbpassword'], node['mysql']['server_root_password'],node['mysql']['server_debian_password'] and node['mysql']['server_repl_password'].
Override other attributes for the community nginx, MySQL server or PHP attributes to your convenience.

```json
{
 "mysql": {
    "server_root_password": "rootpass",
    "server_debian_password": "debpass",
    "server_repl_password": "replpass"
  },
  "owncloud": {
    "adminpassword": "myverysecurepassword1",
    "mysql": {
      "dbpassword": "myverysecurepassword2"
    }
  },
  "run_list": [
    "recipe[owncloud::default]"
  ]
}
```

## Vagrant

A Vagrantfile is provided for testing the installation on Ubuntu 12.04
and Ubuntu 14.04 . 
The Vagrant setup requires berkshel (installing it using the Chef-SDK
package is highly recommended) and the vagrant-berkshelf plugin.

The following ports are forwarded :

### Ubuntu 12.04

* (local) 8090 -> (guest) 80
* (local) 8091 -> (guest) 443


### Ubuntu 14.04

* (local) 8092 -> (guest) 80
* (local) 8093 -> (guest) 443

When using the Vagrant 

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: David Pando (david.pando@gmail.com)
