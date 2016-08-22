class wal_e::install{


  file {$wal_e::env_dir:
    ensure => 'directory',
    owner => $wal_e::user,
    group => $wal_e::group,
    mode => '0550',
  }->
  file {"$wal_e::env_dir/env":
    ensure => 'directory',
    owner => $wal_e::user,
    group => $wal_e::group,
    mode => '0550',
    recurse => true,
    purge => true,
  }

  case $wal_e::install_method {
    'pip': {
      class {'wal_e::packages':
      } ->
      package {'wal-e':
        ensure => $wal_e::version,
        provider => 'pip',
      }
    }
    'source': {
      $src_install_dir = "${::wal_e::env_dir}/.src"
      class {'wal_e::packages':
      } ->
      vcsrepo { $src_install_dir:
        ensure => 'present',
        provider => 'git',
        source => $wal_e::repository_url,
        revision => $wal_e::git_version,
      }
      exec {'wal_e_install_src':
        cwd => $src_install_dir,
        command => '/usr/bin/python .setup.py install',
        refreshonly => true,
        subscribe => Vcsrepo[$src_install_dir],
      }
    }
    'package': {
      package {'python-wal-e':
        ensure => 'present',
      }
    }
  }

  #base backup cmd
  file { "${wal_e::env_dir}/base_backup.sh":
    ensure => 'present',
    content => "envdir ${::wal_e::env_dir}/env wal-e backup-push ${::wal_e::base_backup_options} ${::wal_e::pgdata_dir}",
    mode => '0754',
    owner => $::wal_e::user,
    group => $::wal_e::group,
    require => File["${wal_e::env_dir}/env"]
  }

  file { "${wal_e::env_dir}/base_backup_list.sh":
    ensure => 'present',
    content => "envdir ${::wal_e::env_dir}/env wal-e backup-list",
    mode => '0754',
    owner => $::wal_e::user,
    group => $::wal_e::group,
    require => File["${wal_e::env_dir}/env"]
  }

  file { "${wal_e::env_dir}/purge_base_backup.sh":
    ensure => 'present',
    content => "envdir ${::wal_e::env_dir}/env wal-e delete --confirm retain ${::wal_e::base_backup_retain}",
    mode => '0754',
    owner => $::wal_e::user,
    group => $::wal_e::group,
    require => File["${wal_e::env_dir}/env"]
  }


  #now config cron job if it is enabled
  if $::wal_e::base_backup_enabled {
    $base_cron_ensure = 'present'
  }else {
    $base_cron_ensure = 'absent'
  }
  cron { 'wal_e_base_backup':
    ensure => $base_cron_ensure,
    command => "envdir ${::wal_e::env_dir}/env wal-e backup-push ${::wal_e::base_backup_options} ${::wal_e::pgdata_dir}",
    user => $wal_e::user,
    hour => $::wal_e::base_backup_hour,
    minute => $::wal_e::base_backup_minute,
    monthday => $::wal_e::base_backup_day,
    month => $::wal_e::base_backup_month,
    weekday => $::wal_e::base_backup_weekday
  }

}
