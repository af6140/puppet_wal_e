class wal_e::azureconfig(
  $wabs_prefix = undef,
  $wabs_account_name = undef,
  $wabs_access_key = undef,
  $wabs_sas_token = undef
){
  validate_string($wabs_prefix)
  validate_string($wabs_access_key)
  validate_string($wabs_account_name)

  $config_vars = {
    'WALE_WABS_PREFIX' => $wabs_prefix,
    'WABS_ACCOUNT_NAME' => $wabs_account_name,
    'WABS_ACCESS_KEY' => $wabs_access_key,
    'WABS_SAS_TOKEN' => $wabs_sas_token
  }

  if $wabs_access_key {
    $real_config_vars=delete($config_vars, 'WABS_SAS_TOKEN')
  }else {
    $real_config_vars=delete($config_vars, 'WABS_ACCESS_KEY')
  }

  $real_config_vars.each |String $key , String $value| {
    file { "${::wal_e::env_dir}/env/$key":
      ensure => present,
      owner => $wal_e::user,
      group => $wal_e::group,
      content => $value,
      mode => '0440'
    }
  }

}
