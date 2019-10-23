#
# Cookbook Name:: stig
# Recipe:: auditd
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Installs the auditd cookbook with the CIS ruleset
#
# See: https://supermarket.chef.io/cookbooks/auditd

# Uncomment this when this gets resolved: https://github.com/chef-cookbooks/auditd/issues/55
# include_recipe 'auditd'

# BEGIN
# Remove this block wnen this gets resolved: https://github.com/chef-cookbooks/auditd/issues/55

# rubocop:disable Style/MixinUsage
extend AuditD::Helper
# rubocop:enable Style/MixinUsage
package auditd_package_name_for(node['platform_family'])

service 'auditd' do
  if platform_family?('rhel') && node['init_package'] == 'systemd' && node['platform_version'] < '7.5'
    reload_command '/usr/libexec/initscripts/legacy-actions/auditd/reload'
    restart_command '/usr/libexec/initscripts/legacy-actions/auditd/restart'
  end
  if platform_family?('rhel') && node['init_package'] == 'systemd' && node['platform_version'] >= '7.5'
    reload_command '/usr/sbin/service auditd reload'
    restart_command '/usr/sbin/service auditd restart'
  end
  supports %i[start stop restart reload status]
  action :enable
end
# END

auditd_config_dir = node['stig']['auditd']['config_dir']

directory auditd_config_dir

# Create auditd configuration file
template File.join(auditd_config_dir, 'auditd.conf') do
  source 'etc_audit_auditd.conf.erb'
  owner 'root'
  group 'root'
  mode 0o640
  notifies :reload, 'service[auditd]', :immediately
end
