# Installs the ruby mysql client library required by some scout plugins
class scout::mysql {
  if $scout::manage_ruby {
    Package['ruby-mysql'] {
      require  => [
        Package['ruby'],
        Package['rubygems'],
      ],
    }
  }
  package { 'ruby-mysql':
    ensure   => present,
    provider => 'gem',
  }
}
