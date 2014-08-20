# Installs the redis client library required by some scout plugins
class scout::redis {
  if (!defined(Package['redis'])) {
    package { 'redis':
      ensure    => present,
      provider  => 'gem',
      require   => [
        Package['rubygems']
      ],
    }
  }
}
