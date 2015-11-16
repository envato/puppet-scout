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
    $add_env_to_cmd = "/usr/bin/env scout ${scout_key} -e ${scout_environment_name}"
  } else {
    $add_env_to_cmd = "/usr/bin/env scout ${scout_key}"
  }
  if is_array($scout_roles) {
    $roles = join($scout_roles, ',')
    $final_cmd = "${add_env_to_cmd} -r ${roles}"
  } else {
    $final_cmd = $add_env_to_cmd
  }

  cron { 'scout':
    ensure  => $ensure,
    user    => $user,
    command => $final_cmd,
    require => User[$user],
  }
}
