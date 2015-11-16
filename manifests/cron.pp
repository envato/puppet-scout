# installs cron
class scout::cron (
  $ensure                 = 'present',
  $user                   = scout,
  $scout_key              = undef,
  $scout_environment_name = undef,
  $cron_environment       = undef,
  $command_suffix         = undef,
  ) {

  if $cron_environment {
    Cron['scout'] { environment => $cron_environment }
  }

  if $command_suffix {
    $cmd = "/usr/bin/env scout ${scout_key} -e ${scout_environment_name} -r ${scout_roles}"
  } else {
    $cmd = "/usr/bin/env scout ${scout_key} -e ${scout_environment_name}"
  }

  cron { 'scout':
    ensure  => $ensure,
    user    => $user,
    command => $cmd,
    require => User[$user],
  }
}
