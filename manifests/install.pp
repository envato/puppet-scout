class scout::package (
  $ensure  => 'latest',
  ) {
  
  package { 'scout':
    ensure   => $ensure,
    provider => 'gem',
  }
}
