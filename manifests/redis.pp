# Installs the redis client library required by some scout plugins
class scout::redis {
  package { 'redis':
    ensure    => present,
    provider  => 'gem',
    require   => [
      Package['ruby'],
      Package['rubygems'],
    ],
  }
}
