#
class wal_e::config {
  case $::wal_e::storage_type {
    'aws' : {
      class {'::wal_e::awsconfig':
        aws_secret_key => $wal_e::storage_configs['aws_secret_key'],
        aws_access_key => $wal_e::storage_configs['aws_access_key'],
        aws_region => $wal_e::storage_configs['aws_region'],
        s3_prefix => $wal_e::storage_configs['s3_prefix'],
        before => Class['::wal_e::cron'],
      }
    }
    'azure': {
      class {'::wal_e::azureconfig':
        wabs_prefix => $wal_e::storage_configs['wabs_prefix'],
        wabs_account_name => $wal_e::storage_configs['wabs_account_name'],
        wabs_access_key => $wal_e::storage_configs['wabs_access_key'],
        wabs_sas_token => $wal_e::storage_configs['wabs_sas_token'],
        before => Class['::wal_e::cron'],
      }
    }
    'google': {
      class {'::wal_e::googleconfig':
        gs_prefix => $wal_e::storage_configs['gs_prefix'],
        google_applcation_credentials => $wal_e::storage_configs['google_applcation_credentials'],
        before => Class['::wal_e::cron'],
      }
    }
    'swift': {
      class {'::wal_e::swiftconfig':
        swift_prefix => $wal_e::storage_configs['swift_prefix'],
        swift_authurl => $wal_e::storage_configs['swift_authurl'],
        swift_tenant => $wal_e::storage_configs['swift_tenant'],
        swift_user => $wal_e::storage_configs['swift_user'],
        swift_password => $wal_e::storage_configs['swift_password'],
        before => Class['::wal_e::cron'],
      }
    }
  }

  class {'::wal_e::cron':

  }

}
