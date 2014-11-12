# Puppet module for scout

[![Build Status](https://travis-ci.org/envato/puppet-scout.svg)](https://travis-ci.org/envato/puppet-scout)

This puppet module installs and manages the scoutapp.com agent.

Using this module is simple. Include it in your node definition and set a scout
key variable. If you use the mysql module including `scout::mysql` will install
the ruby library needed to run scout mysql plugins.

If you wish to set the public cert for scout so that you can install custom
signed plugins you can do this using the `public_cert` parameter. If you provide
this parameter you may wish to also set the `home_dir` parameter, otherwise it
will default to `"/home/${user}"`.

## Example

```puppet
node foo.example.com {
  class { 'scout':
    scout_key              => 'fea6b370-d2c8-7d2c-d52b-d25790ab2fb0',
    user                   => 'unprivileged_joe'
    # Optional
    home_dir               => '/home/user',
    public_cert            => 'contents_of_public_cert',
    scout_environment_name => 'production',
    manage_ruby            => true,
  }
}
```

It is important to note: If you do not have a corresponding environment set up
correctly in the scout dashboard, the `scout_environment_name` will not have any
effect.
