require 'spec_helper'

describe 'scout::cron' do

  it 'should compile' do
    should contain_class('scout::cron')
  end

  context 'with scout_roles' do
    it 'should install cron with roles' do
      should contain_cron('scout').with(
        'ensure'  => 'present',
        'command' => '/usr/bin/env scout blah -e blah -r arole,brole,crole',
        'user'    => 'scout'
      )
    end
  end

  context 'without scout_roles' do
    let(:facts) { { :special => 'special' } }
    it 'should install cron without roles' do
      should contain_cron('scout').with(
        'ensure'  => 'present',
        'command' => '/usr/bin/env scout blah -e blah',
        'user'    => 'scout'
      )
    end
  end
end
