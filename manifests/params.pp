class wal_e::params {
  $install_method = 'pip'
  $repository_url = 'https://github.com/wal-e/wal-e.git'
  $version = '0.9.2'
  $git_version = "v${version}"
  $env_dir = '/etc/wal-e.d'
  $base_backup_disabled = false
  $base_backup_minute = 0
  $base_backup_hour = 0
  $base_backup_day = '*'
  $base_backup_month = '*'
  $base_backup_weekday = '1'
  $base_backup_options = '--pool-size 8' #this is the default

  $user = 'postgres'
  $group = 'postgres'
  $pip_user = 'root'
  $pgdata_dir = '/var/lib/pgsql/data'

  $packages  = [
    'gcc',
    'make',
    'libevent-devel',
    'libxslt-devel',
    'lzop',
    'postgresql',
    'postgresql-devel',
    'python-devel',
    'python-setuptools',
    'python-pip',
    'git',
  ]

  $pips = [
    'argparse',
    'boto',
    'gevent'
  ]

  $storage_type = 'aws'
}
