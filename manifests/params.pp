class wal_e::params {
  $install_method = 'pip'
  $repository_url = 'https://github.com/wal-e/wal-e.git'
  $version = '0.9.2'
  $git_version = "v${version}"
  $env_dir = '/etc/wal-e.d'
  $base_backup_enabled = false
  $base_backup_minute = 0
  $base_backup_hour = 0
  $base_backup_day = '*'
  $base_backup_month = '*'
  $base_backup_weekday = '1'
  $base_backup_options = '' #this is the default

  $user = 'postgres'
  $group = 'postgres'
  $pip_user = 'root'
  $pgdata_dir = '/var/lib/pgsql/data'

  $storage_type = 'aws'

  case $::osfamily {
    'RedHat': {
      $packages  = [
        'gcc',
        'make',
        'libevent-devel',
        'libxslt-devel',
        'lzop',
        'postgresql-devel',
        'python-devel',
        'python-setuptools',
        'python-pip',
        'git',
        'pv',
        'python-gevent',
      ]
    }
    'Debian': {
      $packages = [
        'build-essential',
        'libevent-dev',
        'libxslt1-dev',
        'lzop',
        'libpq-dev',
        'python-dev',
        'python-pip',
        'git',
        'pv',
        'python-gevent'
      ]
    }
    default: {

    }
  }

  $pips = [
    'boto',
    'azure',
    'gcloud',
    'python-swiftclient',
    'python-keystoneclient'
  ]


}
