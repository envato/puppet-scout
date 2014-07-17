# Installs the sidekiq required by some scout plugins
class scout::sidekiq {
  package { 'sidekiq':
    ensure    => present,
    provider  => 'gem',
    require   => [
      Package['ruby'],
      Package['rubygems'],
    ],
  }
}
