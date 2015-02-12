# = Class: scout::manage_puppet_state_dir
#
# This class manages the Puppet state directory to allow Scout to monitor it.
#
# == Parameters:
#
# $group::      Group to own the directory. Defaults to 'puppet'.
# $mode::       Mode for the directory. Defaults to '0755'.
# $owner::      User to own the directory. Defaults to 'puppet'.
# $path::       Directory to manage. Defaults to '/var/lib/puppet'.
#
# == Requires:
#
# Nothing.
#
# == Sample Usage:
#
#   class { 'scout::manage_puppet_state_dir':
#     group  => 'puppet',
#     mode   => '0755',
#     owner  => 'puppet',
#     path   => '/var/lib/puppet',
#   }
#
class scout::manage_puppet_state_dir (
  $group = hiera('scout::manage_puppet_state_dir::group', 'puppet'),
  $mode = hiera('scout::manage_puppet_state_dir::mode', '0755'),
  $owner = hiera('scout::manage_puppet_state_dir::owner', 'puppet'),
  $path = hiera('scout::manage_puppet_state_dir::path', '/var/lib/puppet'),
) {

  file {"scout::manage_puppet_state_dir: ${path}":
    ensure => directory,
    group  => $group,
    mode   => $mode,
    owner  => $owner,
    path   => $path,
  }
}
