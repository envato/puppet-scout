require 'spec_helper'

describe 'scout::cron' do

  it 'should compile' do
    should contain_class('scout::cron')
  end

  context 'without scout_roles or scout_environment_name' do
    it 'should install cron without roles or environment' do
      should contain_cron('scout').with(
        'ensure'      => 'present',
        'environment' => 'SCOUT_KEY=key',
        'command'     => '/usr/bin/env scout ${SCOUT_KEY}',
        'user'        => 'scout'
      )
    end
  end

  context 'with just environment set' do
    let(:params) { { :scout_environment_name => 'blah' } }
    it 'should install with only environment' do
      should contain_cron('scout').with(
        'ensure'      => 'present',
        'environment' => 'SCOUT_KEY=key',
        'command'     => '/usr/bin/env scout ${SCOUT_KEY} -e blah',
        'user'        => 'scout'
      )
    end
  end

  context 'with scout_roles and environment' do
    let(:facts) { { :special => 'special' } }
    it 'should install cron with roles and environment' do
      should contain_cron('scout').with(
        'ensure'      => 'present',
        'environment' => 'SCOUT_KEY=key',
        'command'     => '/usr/bin/env scout ${SCOUT_KEY} -e blah -r arole,brole,crole',
        'user'        => 'scout'
      )
    end
  end

  context 'with scout_roles and no environment' do
    let(:facts) { { :special => 'more_special' } }
    it 'should install cron with roles' do
      should contain_cron('scout').with(
        'ensure'      => 'present',
        'environment' => 'SCOUT_KEY=key',
        'command'     => '/usr/bin/env scout ${SCOUT_KEY} -r arole,brole,crole',
        'user'        => 'scout'
      )
    end
  end

  context 'with cron environment set' do
    let(:params) { { :cron_environment => 'MAILTO=scout-mailbox@my.org' } }
    it 'adds the key to the cron environment' do
      is_expected.to contain_cron('scout').with(
        'ensure'      => 'present',
        'environment' => "SCOUT_KEY=key\nMAILTO=scout-mailbox@my.org",
        'command'     => '/usr/bin/env scout ${SCOUT_KEY}',
        'user'        => 'scout'
      )
    end
  end
end
