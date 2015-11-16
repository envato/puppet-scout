# Manages scoutapp.com agent
class scout(
  $ensure                 = 'present',
  $scout_key              = undef,
  $user                   = 'scout',
  $group                  = 'scout',
  $groups                 = undef,
  $cron_environment       = undef,
  $home_dir               = '/home/scout',
  $managehome             = true,
  $public_cert            = undef,
  $manage_ruby            = false,
) {

  if $ensure == 'present' {
    $dir_ensure = 'directory'
  } else {
    $dir_ensure = 'absent'
  }

  class { 'scout::user':
    ensure     => $ensure,
    user       => $user,
    homedir    => $home_dir,
    group      => $group,
    groups     => $groups,
    managehome => $managehome,
  }

  if $public_cert {
    $scout_cert_path = "${home_dir}/.scout"

    file { $scout_cert_path:
      ensure  => $dir_ensure,
      owner   => $user,
      require => User[$user],
    }

    file { "${scout_cert_path}/scout_rsa.pub":
      ensure  => $ensure,
      content => $public_cert,
      owner   => $user,
      require => [
        File[$scout_cert_path],
        User[$user],
      ],
    }
  }

  if $manage_ruby {
    Package['scout'] {
      require  => [
        Package['ruby'],
        Package['rubygems'],
      ],
    }
    include scout::ruby
  }

  class { 'scout::install': ensure => 'latest' }

  class { 'scout::cron':
    ensure    => $ensure,
    user      => $user,
    scout_key => $scout_key,
  }
}
