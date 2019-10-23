require 'spec_helper'

describe 'stig::rsyslog CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.7.1908').converge('stig::rsyslog') }
  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('rsyslog::default')
  end
  it 'includes the other_cookbook' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('rsyslog::default')
    chef_run
  end
end
describe 'stig::rsyslog CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::rsyslog') }
  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('rsyslog::default')
  end
  it 'includes the other_cookbook' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('rsyslog::default')
    chef_run
  end
end
