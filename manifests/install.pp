class wal_e::install{

  file {$wal_e::env_dir:
    ensure => 'directory',
    owner => $wal_e::user,
    group => $wal_e::group,
    mode => '0750',
  }->
  file {"$wal_e::env_dir/env":
    ensure => 'directory',
    owner => $wal_e::user,
    group => $wal_e::group,
    mode => '0750',
    recurse => true,
    purge => true,
  }

  case $wal_e::install_method {
    'pip': {
      class {'wal_e::packages':
        require => File[$wal_e::env_dir]
      } ->
      exec {'install_wall_e':
        command => "pip install -b ${wal_e::env_dir} -q wal_e==${wal_e::version}",
        path => ['/bin', '/usr/bin', '/sbin', '/usr/sbin', '/usr/local/bin'],
        creates => "${wal_e::env_dir}/.installed_flag",
        require => File[$wal_e::env_dir],
        unless => "pip freeze |grep -q wal-e==${wal_e::version}",
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

  $base_backup_cmd = @("END")
  #!/bin/bash
  envdir ${::wal_e::env_dir}/env wal-e backup-push ${::wal_e::base_backup_options} ${::wal_e::pgdata_dir}
  END

  $base_backup_list_cmd = @("END")
  #!/bin/bash
  envdir ${::wal_e::env_dir}/env wal-e backup-list
  END

  #base backup cmd
  file { "${wal_e::env_dir}/base_backup.sh":
    ensure => 'present',
    content => $base_backup_cmd,
    mode => '0754',
    owner => $::wal_e::user,
    group => $::wal_e::group,
    require => File[$::wal_e::env_dir]
  }

  file { "${wal_e::env_dir}/base_backup_list.sh":
    ensure => 'present',
    content => $base_backup_list_cmd,
    mode => '0754',
    owner => $::wal_e::user,
    group => $::wal_e::group,
    require => File[$::wal_e::env_dir]
  }

  file { "${wal_e::env_dir}/purge_base_backup.sh":
    ensure => 'present',
    content => template('wal_e/purge_base_backup.sh.erb'),
    mode => '0754',
    owner => $::wal_e::user,
    group => $::wal_e::group,
    require => File[$::wal_e::env_dir]
  }

}
