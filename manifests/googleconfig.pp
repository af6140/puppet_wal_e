class wal_e::googleconfig(
  $gs_prefix = undef,
  $google_applcation_credentials = undef,
) {
  validate_string($gs_prefix)
  validate_absolute_path($google_applcation_credentials)

  if $gs_prefix {
    file { "${::wal_e::env_dir}/env/WALE_GS_PREFIX":
      ensure => present,
      owner => $wal_e::user,
      group => $wal_e::group,
      content => $gs_prefix,
      mode => '0440'
    }
  }

  if $google_applcation_credentials {
    #it is a json file
    validate_absolute_path($google_applcation_credentials)
    file { "${::wal_e::env_dir}/env/GOOGLE_APPLCATION_CREDENTIALS":
      ensure => present,
      owner => $wal_e::user,
      group => $wal_e::group,
      content => $gs_prefix,
      mode => '0440'
    }
  }

}
