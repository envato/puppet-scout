# Manages scoutapp.com agent
class scout(
  $scout_key        = undef,
  $user             = 'scout',
  $cron_environment = undef,
  $home_dir         = '',
  $public_cert      = undef,
  $scout_environment_name = 'production'
) {

  if $home_dir == '' and $user != '' {
    $valid_home_dir="/home/${user}"
  } else {
    $valid_home_dir=$home_dir
  }

  if $public_cert {
    $scout_cert_path = "${valid_home_dir}/.scout"

    file { $scout_cert_path:
      ensure  => directory,
      owner   => $user,
      require => User[$user],
    }

    file { "${scout_cert_path}/scout_rsa.pub":
      content => $public_cert,
      owner   => $user,
      require => [
        File[$scout_cert_path],
        User[$user],
      ],
    }
  }

  if (! defined(Package['ruby'])) {
    package { 'ruby':
      ensure  => present,
    }
  }
  if (! defined(Package['rubygems'])) {
    package { 'rubygems':
      ensure  => present,
    }
  }

  package { 'scout':
    ensure   => 'latest',
    provider => 'gem',
    require  => [
      Package['ruby'],
      Package['rubygems'],
    ],
  }

  cron { 'scout':
    require     => User[$user],
    user        => $user,
    command     => "/usr/bin/env scout ${scout_key} -e ${scout_environment_name}",
    environment => $cron_environment,
  }

  file { '/var/lib/puppet':
    ensure => directory,
    owner  => 'puppet',
    group  => 'puppet',
    mode   => '0755',
  }

  if (! defined(User[$user])) {
    user { $user:
      ensure     => 'present',
      managehome => true,
      home       => $valid_home_dir,
    }
  }
}
