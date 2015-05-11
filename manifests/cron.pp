class scout::cron (
  $ensure                 = 'present',
  $user                   = scout,
  $scout_key              = undef,
  $scout_environment_name = undef,
  $cron_environment       = undef
  ) {

  if $cron_environment {
    Cron['scout'] { environment => $cron_environment }
  }

  cron { 'scout':
    ensure      => $ensure,
    user        => $user,
    command     => "/usr/bin/env scout ${scout_key} -e ${scout_environment_name}",
    require     => User[$user],
  }
}
