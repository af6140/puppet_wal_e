class wal_e::config {

  case $::wal_e::storage_type {
    'aws' : {
      class {'::wal_e::awsconfig':
        aws_secret_key => $wal_e::storage_configs['aws_secret_key'],
        aws_access_key => $wal_e::storage_configs['aws_access_key'],
        aws_region => $wal_e::storage_configs['aws_region'],
        s3_prefix => $wal_e::storage_configs['s3_prefix'],
        require => File["${wal_e::env_dir}/env"],
      }
    }
  }
}
