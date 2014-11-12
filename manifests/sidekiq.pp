# Installs the sidekiq required by some scout plugins
class scout::sidekiq (
  $version = '2.8.0'
  ) {
  if $scout::manage_ruby {
    Package['sidekiq'] {
      require  => [
        Package['ruby'],
        Package['rubygems'],
      ],
    }
  }
  package { 'sidekiq':
     ensure   => $version,
     provider => 'gem',
  }
}
