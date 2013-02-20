# Manages scoutapp.com agent
class scout(
  $scout_key,
  $user,
  $cron_environment = undef,
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
}
