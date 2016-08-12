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
  file { "/usr/local/bin/base_backup.sh":
    ensure => 'present',
    content => "/usr/bin/envdir ${::wal_e::env_dir} wal-e backup-push ${::wal_e::pgdata_dir}"
    mode => '0754'
  }
}
