# Install config file needed by scout plugin
class scout::pt_heartbeat {
  $monitor_user = hiera('scout::replication_monitoring_user','')
  $monitor_password = hiera('scout::replication_monitoring_password','')
  $monitor_database = hiera('scout::replication_monitoring_database','')
  $user = hiera('scout::user','scout')
  $home_dir = hiera('scout::home_dir','/home/scout')

  file {'scout-pt-heartbeat-config-file':
    ensure  => file,
    require => User[$user],
    path    => "${home_dir}/.pt-heartbeat.cfg",
    owner   => $user,
    mode    => '0400',
    content => template('scout/heartbeat-config.erb')
  }
}
