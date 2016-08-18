class wal_e::packages(
    $os_packages = $wal_e::packages,
    $pip_packages = $wal_e::pips
) {

  if $os_packages {
    ensure_resource('package', $os_packages, {'ensure' => 'present'})
  }
  if $pip_packages {
    ensure_resource('package', $pip_packages, {'ensure' => 'present', 'provider' => 'pip'})
  }

  if $os_packages and $pip_packages {
    Package[$os_packages] -> Package[$pip_packages]
  }

}
