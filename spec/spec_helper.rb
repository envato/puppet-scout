dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift File.join(dir, 'lib')

require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|

  c.before :each do
    # Ensure that we don't accidentally cache facts and environment
    # between test cases.
    Facter::Util::Loader.any_instance.stubs(:load_all)
    Facter.clear
    Facter.clear_messages

    # Store any environment variables away to be restored later
    @old_env = {}
    ENV.each_key { |k| @old_env[k] = ENV[k] }

    Puppet.settings[:strict_variables] = true if ENV['STRICT_VARIABLES'] == 'yes'
  end
  c.hiera_config = File.join(File.expand_path(File.dirname(__FILE__)), '..', '.hiera_rspec.yaml')
end
