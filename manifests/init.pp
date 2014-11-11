# Manages scoutapp.com agent
class scout(
  $scout_key        = undef,
  $user             = 'scout',
  $cron_environment = undef,
  $home_dir         = '',
  $public_cert      = undef,
  $scout_environment_name = 'production',
  $manage_ruby      = false,
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

  if $manage_ruby {
    Package['scout'] {
      require  => [
        Package['ruby'],
        Package['rubygems'],
      ],
    }
    package { 'ruby':
      ensure  => present,
    }
    package { 'rubygems':
      ensure  => present,
    }
  }

  package { 'scout':
    ensure   => 'latest',
    provider => 'gem',
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

  user { $user:
    ensure     => 'present',
    managehome => true,
    home       => $valid_home_dir,
  }
}
