class wal_e::install{

  file {$wal_e::env_dir:
    ensure => 'directory',
    owner => $wal_e::user,
    group => $wal_e::group,
    mode => '0550',
  } ->
  file {"$wal_e::env_dir/env":
    ensure => 'directory',
    owner => $wal_e::user,
    group => $wal_e::group,
    mode => '0550',
    recurse => true,
    purge => true,
  }
  package {$wal_e::packages:
    ensure => 'present'
  }
  package {$wal_e::pips:
    ensure => 'present',
    provider => 'pip',
  }

  case $wal_e::install_method {
    'pip': {
      package {'wal-e':
        ensure => $wal_e::version,
        provider => 'pip',
      }
    }
    'source': {
      $src_install_dir = "${::wal_e::env_dir}/.src"
      vcsrepo { $src_install_dir:
        ensure => 'present',
        provider => 'git',
        source => $wal_e::repository_url,
        revision => $wal_e::git_version,
      }
      exec {'wal_e_install_src':
        cwd => $src_install_dir,
        cmd => '/usr/bin/python .setup.py install',
        refreshonly => true,
        subscribe => Vcsrepo[$src_install_dir],
      }
    }
  }

  #base backup cmd
  file { "/usr/local/bin/base_backup.sh":
    content => "/usr/bin/envdir ${::wal_e::env_dir} wal-e backup-push ${::wal_e::pgdata_dir}"
  }
}
