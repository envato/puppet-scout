require 'spec_helper'

describe 'scout::install' do

  it 'should compile' do
    should contain_class('scout::install')
  end

  it 'scout gem is installed' do
    should contain_package('^scout$').with(
      'ensure' => 'latest',
      'provider' => 'gem'
    )
  end
end
