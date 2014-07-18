# Installs the sidekiq required by some scout plugins
class scout::sidekiq (
  $version = '2.8.0'
)
{
  package { 'sidekiq':
    ensure    => $version,
    provider  => 'gem',
    require   => [
      Package['ruby'],
      Package['rubygems'],
    ],
  }
}
