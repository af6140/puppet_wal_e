# puppet_wal_e

## Description
Postgresql *wal_e* puppet module, install wal-e backup program from source or through pip. Some parts are based on chef module from wal-e project.

It supports *cron* job setup for base backup.

Most functionality has been tested on Centos 7 and Ubuntu 14.04.

## Requirement
*env_dir* of Daemontools package is required to ease setup of environment variables for different storage backends

Python and pip dependencies will be installed, documented at wal_e github page.

Depends on the cloud storage backend, configuration is required.

## Usage

```
class {'wal_e':
 env_dir => '/etc/wal-e.d' #default to this folder
 user => 'postgres',
 group => 'postgres',
 storage_type => 'aws' #default to ws
 storage_configs => {
   's3_prefix' => 's3://dummy',
   'aws_secret_key' => '',
   'aws_access_key' => '',
   'aws_region' => 'us-east-1',
 }
}
```
