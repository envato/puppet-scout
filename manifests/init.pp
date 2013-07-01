# Manages scoutapp.com agent
class scout(
  $scout_key,
  $user,
  $cron_environment = undef,
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
  if $user and $public_cert {
    file { "/home/${user}/.scout/scout_rsa.pub":
      content => $public_cert,
      owner => $user,
    }
  }
}
