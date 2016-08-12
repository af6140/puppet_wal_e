class wal_e::awsconfig (
  $aws_access_key = undef,
  $aws_secret_key = undef,
  $aws_region = undef,
  $s3_prefix = undef,
  $aws_security_token = undef,
){

  $config_vars = {
    'WALE_S3_PREFIX' => $s3_prefix,
    'AWS_ACCESS_KEY_ID' => $aws_access_key,
    'AWS_SECRET_ACCESS_KEY' => $aws_secret_key,
    'AWS_REGION' => $aws_region
  }
  $config_vars.each |String $key , String $value| {
    file { "${::wal_e::env_dir}/env/$key":
      ensure => present,
      owner => $wal_e::user,
      group => $wal_e::group,
      content => $value,
      mode => '0440'
    }
  }

}
