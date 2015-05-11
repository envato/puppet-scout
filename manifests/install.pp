# installs scout gem
class scout::install (
  $ensure  = 'latest',
  ) {

  package { 'scout':
    ensure   => $ensure,
    provider => 'gem',
  }
}
