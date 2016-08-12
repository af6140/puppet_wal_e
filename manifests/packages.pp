class wal_e::packages(
    $os_packges = $wal_e::packages,
    $pip_packages = $wal_e::pips
) {

  if $os_packges {
    ensure_resource('package', $os_packges, {'ensure' => 'present'})

  }
  if $pip_packages {
    ensure_resource('package', $pip_packages, {'ensure' => 'present', 'provider' => 'pip', 'require' => [Package['python-pip'], Package['python-devel'], Package['postgresql'], Package['postgresql-devel']]})
      # package {$wal_e::pips:
      #   ensure => 'present',
      #   provider => 'pip',
      #   require => Package['python-pip'],
      # }
      #
  }

}
