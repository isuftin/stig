# frozen_string_literal: true

# Cookbook Name:: stig
# Recipe:: rsyslog
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure /etc/rsyslog.conf
#
# CIS Benchmark Items
# RHEL6:  5.1.3
# CENTOS6: 4.1.3
# UBUNTU: 8.2.3

node.default['rsyslog']['default_facility_logs'] = node['stig']['logging']['rsyslog_rules_debian'] if %w[debian ubuntu].include?(node['platform'])

node.default['rsyslog']['default_facility_logs'] = node['stig']['logging']['rsyslog_rules_rhel'] if %w[rhel fedora centos].include?(node['platform'])

include_recipe 'rsyslog::default'
