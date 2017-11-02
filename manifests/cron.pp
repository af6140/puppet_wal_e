class wal_e::cron(
  $base_backup_purge_enabled = $wal_e::base_backup_purge_enabled,
  $base_backup_enabled = $wal_e::base_backup_enabled,
  $user = $wal_e::user,
  $hour = $::wal_e::base_backup_hour,
  $minute = $::wal_e::base_backup_minute,
  $monthday = $::wal_e::base_backup_day,
  $month = $::wal_e::base_backup_month,
  $weekday = $::wal_e::base_backup_weekday,
  $description = 'wal_e_back_backup cron job',
  $cmd_wrapper = $::wal_e::cron_wrapper,
  $purge_cmd_wrapper = $::wal_e::purge_cron_wrapper,
  $purge_cron_delay_minutes = $::wal_e::purge_cron_delay_minutes,
) {
  #now config cron job if it is enabled
  if $cmd_wrapper and ! empty($cmd_wrapper) {
    if $base_backup_purge_enabled {
      $cron_cmd = "${cmd_wrapper} ${::wal_e::env_dir}/base_backup.sh"
      $purge_cron_cmd = "${purge_cmd_wrapper} ${::wal_e::env_dir}/purge_base_backup.sh"
    } else {
      $cron_cmd = "${cmd_wrapper} ${::wal_e::env_dir}/base_backup.sh"
      $purge_cron_cmd = undef
    }
  }else {
    if $base_backup_purge_enabled {
      $cron_cmd = "${::wal_e::env_dir}/base_backup.sh && ${::wal_e::env_dir}/purge_base_backup.sh"
    } else {
      $cron_cmd = "${::wal_e::env_dir}/base_backup.sh"
    }
  }

  if $base_backup_enabled {
    $base_cron_ensure = 'present'
    if($base_backup_purge_enabled) {
      $purge_cron_ensure = 'present'
    }else {
      $purge_cron_ensure = 'absent'
    }
  }else {
    $base_cron_ensure = 'absent'
    $purge_cron_ensure = 'absent'
  }


  cron::job { 'wal_e_base_backup':
    ensure => $base_cron_ensure,
    command => $cron_cmd,
    user => $user,
    hour => $hour,
    minute => $minute,
    date => $monthday,
    month => $month,
    weekday => $weekday,
    description => $description,
  }

  if $base_backup_purge_enabled and $purge_cron_cmd {
    cron::job { 'wal_e_base_backup_purge':
      ensure      => $purge_cron_ensure,
      command     => $purge_cron_cmd,
      user        => $user,
      hour        => $hour,
      minute      => $minute+$purge_cron_delay_minutes,
      date        => $monthday,
      month       => $month,
      weekday     => $weekday,
      description => $description,
    }
  }

}