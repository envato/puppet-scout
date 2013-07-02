# Manages scoutapp.com agent
class scout(
  $scout_key,
  $user,
  $cron_environment = undef,
  $home_dir = undef,
  $public_cert = undef,
) {
  package { 'scout':
    ensure   => 'installed',
    provider => 'gem';
  }

  # set up the cronjob that runs the agent every minute
  cron { 'scout':
    user        => $user,
    command     => "/usr/bin/env scout ${scout_key}",
    environment => $cron_environment,
  }

  # Install the public cert if defined so we can install custom plugins
  if $public_cert {
    if $home_dir {
      $scout_cert_path = "${home_dir}/.scout"
    } else {
      $scout_cert_path = "/home/${user}/.scout"
    }
    file { "${scout_cert_path}/scout_rsa.pub":
      content => $public_cert,
      owner => $user,
    }
  }
}
