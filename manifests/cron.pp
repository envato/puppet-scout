# installs cron
class scout::cron (
  $ensure                 = 'present',
  $user                   = scout,
  $scout_key              = undef,
  $scout_environment_name = undef,
  $cron_environment       = undef,
  ) {

  $scout_roles = hiera_array('scout::roles', undef)

  if $cron_environment {
    Cron['scout'] { environment => $cron_environment }
  }

  if $scout_environment_name {
    $scout_environment_switch = " -e ${scout_environment_name}"
  }

  if is_array($scout_roles) {
    $roles = join($scout_roles, ',')
    $scout_roles_switch = " -r ${roles}"
  }

  cron { 'scout':
    ensure  => $ensure,
    user    => $user,
    command => "/usr/bin/env scout ${scout_key}${scout_environment_switch}${scout_roles_switch}",
    require => User[$user],
  }
}
