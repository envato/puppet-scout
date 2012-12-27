# Manages scoutapp.com agent
class scout($scout_key=false) {
  package {
    'scout':
      ensure   => 'installed',
      provider => 'gem';
  }

  # set up the cronjob that runs the agent every minute
  if $scout_key {
    cron {
      'scout':
        command => "/var/lib/gems/1.8/bin/scout ${scout_key}";
    }
  }
}
