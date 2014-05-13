# Installs the ruby mysql client library required by some scout plugins
class scout::mysql {
  package { 'ruby-mysql':
    ensure    => present,
    provider  => 'gem',
    require   => [
      Package['ruby'],
      Package['rubygems'],
    ],
  }
}
