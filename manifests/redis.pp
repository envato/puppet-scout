# Installs the redis client library required by some scout plugins
class scout::redis {
  if $scout::manage_ruby {
    Package['redis'] {
      require  => [
        Package['ruby'],
        Package['rubygems'],
      ],
    }
  }
  package { 'redis':
    ensure   => present,
    provider => 'gem',
  }
}
