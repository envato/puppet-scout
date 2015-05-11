# add scout user and groups
class scout::user (
  $ensure    = 'present',
  $user      = 'scout',
  $homedir   = '/home/scout',
  $group      = 'scout',
  $managehome = true,
  $groups     = []
  ) {

  validate_absolute_path($homedir)

  group { $group:
    ensure => $ensure,
  }

  if is_array($groups) {
    User[$user] { groups => $groups }
  } else {
    User[$user] { groups => any2array($groups) }
  }

  user { $user:
    gid        => $group,
    home       => $homedir,
    managehome => $managehome,
    require    => Group[$group],
  }
}
