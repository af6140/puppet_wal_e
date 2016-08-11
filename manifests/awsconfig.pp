class wal_e::awsconfig (
  $aws_access_key = undef,
  $aws_secret_key = undef,
  $aws_region = undef,
  $s3_prefix = undef,
){

  if $s3_prefix {
    file { "${::wal_e::env_dir}/env/WALE_S3_PREFIX":
      ensure => present,
      owner => $wal_e::user,
      group => $wal_e::group,
      content => $s3_prefix,
      mode => '0440'
    }
  }

  if $aws_access_key {
    file { "${::wal_e::env_dir}/env/AWS_ACCESS_KEY_ID":
      ensure => present,
      owner => $wal_e::user,
      group => $wal_e::group,
      content => $aws_access_key,
      mode => '0440'
    }
  }

  if $aws_secret_key {
    file { "${::wal_e::env_dir}/env/AWS_SECRET_ACCESS_KEY":
      ensure => present,
      owner => $wal_e::user,
      group => $wal_e::group,
      content => $aws_secret_key,
      mode => '0440'
    }
  }

  if $aws_region {
    file { "${::wal_e::env_dir}/env/AWS_REGION":
      ensure => present,
      owner => $wal_e::user,
      group => $wal_e::group,
      content => $aws_region,
      mode => '0440'
    }
  }


}
