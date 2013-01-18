# Manages scoutapp.com agent
class scout($scout_key=false, $user="root") {
  package {
    'scout':
      ensure   => 'installed',
      provider => 'gem';
  }

  # set up the cronjob that runs the agent every minute
  if $scout_key {
    cron {
      'scout':
        user    => $user,
        command => "/var/lib/gems/1.8/bin/scout ${scout_key}";
    }
  }
}
