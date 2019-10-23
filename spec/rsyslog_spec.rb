require 'spec_helper'

describe 'stig::rsyslog CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.7.1908').converge('stig::rsyslog') }

  describe 'includes the third party rsyslog::default recipe' do
    it { is_expected.to include_recipe('rsyslog::default') }
  end
end

describe 'stig::rsyslog CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::rsyslog') }

  describe 'includes the third party rsyslog::default recipe' do
    it { is_expected.to include_recipe('rsyslog::default') }
  end
end
