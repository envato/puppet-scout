# Install config file needed by scout plugin
class scout::pt_heartbeat {
  $monitor_user = hiera('scout::replication_monitoring_user','')
  $monitor_password = hiera('scout::replication_monitoring_password','')
  $monitor_database = hiera('scout::replication_monitoring_database','')

  file {'scout-pt-heartbeat-config-file':
    ensure  => file,
    require => User[$scout::user],
    path    => "${scout::home_dir}/.pt-heartbeat.cfg",
    owner   => $scout::user,
    mode    => '0400',
    content => template('scout/heartbeat-config.erb')
  }
}
