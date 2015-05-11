class scout::cron (
  $ensure                 = 'present',
  $user                   = scout,
  $scout_key              = undef,
  $scout_environment_name = undef,
  $cron_environment       = undef
  ) {
  cron { 'scout':
    ensure      => $ensure,
    user        => $user,
    command     => "/usr/bin/env scout ${scout_key} -e ${scout_environment_name}",
    environment => ${cron_environment},
    require     => User[$user],
  }
}
