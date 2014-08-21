# Installs the sidekiq required by some scout plugins
class scout::sidekiq (
  $version = '2.8.0'
)
{
  if (!defined(Package['sidekiq'])) {
    package { 'sidekiq':
      ensure    => $version,
      provider  => 'gem',
      require   => [
        Package['rubygems'],
      ],
    }
  }
}
