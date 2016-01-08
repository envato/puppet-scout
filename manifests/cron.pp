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
    $environment = join(["SCOUT_KEY=${scout_key}", '\n', $cron_environment])
  }
  else
  {
    $environment = "SCOUT_KEY=${scout_key}"
  }

  if $scout_environment_name {
    $scout_environment_switch = " -e ${scout_environment_name}"
  }

  if is_array($scout_roles) {
    $roles = join($scout_roles, ',')
    $scout_roles_switch = " -r ${roles}"
  }

  $command = "/usr/bin/env scout \${SCOUT_KEY}${scout_environment_switch}${scout_roles_switch}"

  cron { 'scout':
    ensure      => $ensure,
    environment => $environment,
    user        => $user,
    command     => $command,
    require     => User[$user],
  }
}
