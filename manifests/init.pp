# Manages scoutapp.com agent
class scout(
  $scout_key        = undef,
  $user             = 'scout',
  $cron_environment = undef,
  $home_dir         = "/home/${user}",
  $public_cert      = undef,
) {

  if $public_cert {
    $scout_cert_path = "${home_dir}/.scout"

    file { $scout_cert_path:
      ensure  => directory,
      owner   => $user,
      require => User[$user],
    }

    file { "${scout_cert_path}/scout_rsa.pub":
      content => $public_cert,
      owner => $user,
      require => [
        File[$scout_cert_path],
        User[$user],
      ],
    }
  }

  package { ['ruby','rubygems']:
    ensure  => present,
  }

  package { 'scout':
    ensure   => 'installed',
    provider => 'gem',
    require  => [
      Package['ruby'],
      Package['rubygems'],
    ],
  }

  cron { 'scout':
    require     => User[$user],
    user        => $user,
    command     => "/usr/bin/env scout ${scout_key}",
    environment => $cron_environment,
  }

  ensure_resource('user', $user, {'ensure' => 'present', 'managehome' => 'true', 'home' => $home_dir})

}
