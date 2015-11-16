# installs cron
class scout::cron (
  $ensure                 = 'present',
  $user                   = scout,
  $scout_key              = undef,
  $scout_environment_name = 'production',
  $cron_environment       = undef,
  ) {

  $scout_roles = hiera_array('scout::roles', undef)

  if $cron_environment {
    Cron['scout'] { environment => $cron_environment }
  }

  if is_array($scout_roles) {
    $roles = join($scout_roles, ',')
    $cmd = "/usr/bin/env scout ${scout_key} -e ${scout_environment_name} -r ${roles}"
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
