class wal_e (
  $install_method = $wal_e::params::install_method,
  $version = $wal_e::params::version,
  $env_dir = $wal_e::params::env_dir,
  $base_backup_enabled = $wal_e::params::base_backup_enabled,
  $base_backup_minute = $wal_e::params::base_backup_minute,
  $base_backup_hour = $wal_e::params::base_backup_hour,
  $base_backup_day = $wal_e::params::base_backup_day,
  $base_backup_month = $wal_e::params::base_backup_month,
  $base_backup_weekday = $wal_e::params::base_backup_weekday,
  $base_backup_options = $wal_e::params::base_backup_options,
  $base_backup_retain = $wal_e::params::base_backup_retain, #days to be retained
  $base_backup_purge_enabled = $wal_e::params::base_backup_purge_enabled,
  $user = $wal_e::params::user,
  $group = $wal_e::params::group,
  $pip_user = $wal_e::params::pip_user,
  $pgdata_dir = $wal_e::params::pgdata_dir,
  $packages = $wal_e::params::packages,
  $pips = $wal_e::params::pips,
  $storage_type = $wal_e::params::storage_type,
  $storage_configs = undef
) inherits wal_e::params {

  validate_absolute_path($env_dir)
  validate_string($storage_type)
  validate_re($storage_type, ['aws','google','azure','swift'])
  validate_string($install_method)
  validate_re($install_method, ['source', 'pip', 'package'])
  validate_hash($storage_configs)
  validate_absolute_path($pgdata_dir)
  validate_integer($base_backup_retain)

  class {'::wal_e::install':
  } ->
  class {'::wal_e::config':
  }

}
