class wal_e::swiftconfig(
  $swift_prefix =  undef,
  $swift_authurl = undef,
  $swift_tenant  = undef,
  $swift_user = undef,
  $swift_password = undef
) {
  $config_vars = {
    'WALE_SWIFT_PREFIX' => $swift_prefix,
    'SWIFT_AUTHURL' => $swift_authurl,
    'SWIFT_TENANT' => $swift_tenant,
    'SWIFT_USER' => $swift_user,
    'SWIFT_PASSWORD' => $swift_password
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
