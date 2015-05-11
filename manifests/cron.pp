class scout::cron (
  $ensure                 = 'present',
  $user                   = scout,
  $scout_key              = undef,
  $scout_environment_name = undef,
  $environment            = undef
  ) {
  cron { 'scout':
    ensure      => $ensure,
    require     => User[$user],
    user        => $user,
    command     => "/usr/bin/env scout ${scout_key} -e ${scout_environment_name}",
    environment => $cron_environment,
  }
}
