control 'rsyslog' do
  impact 'medium'
  title 'rsyslog: ensure syslog configuration is set properly'
  tag 'rsyslog'

  # CENTOS6: 4.1.3
  # UBUNTU: 8.2.3

  describe file('/etc/rsyslog.conf') do
    it { should be_file }
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
  end

  describe file('/etc/rsyslog.d/50-default.conf') do
    its('content') { should match(%r{\*.emerg\s*?:omusrmsg:\*}) }
    its('content') { should match(%r{mail.\*\s*?-/var/log/mail}) }
    its('content') { should match(%r{mail.info\s*?-/var/log/mail.info}) }
    its('content') { should match(%r{mail.warning\s*?-/var/log/mail.warn}) }
    its('content') { should match(%r{mail.err\s*?/var/log/mail.err}) }
    its('content') { should match(%r{news.crit\s*?-/var/log/news/news.crit}) }
    its('content') { should match(%r{news.err\s*?-/var/log/news/news.err}) }
    its('content') { should match(%r{news.notice\s*?-/var/log/news/news.notice}) }
    its('content') { should match(%r{\*.=warning;\*.=err\s*?-/var/log/warn}) }
    its('content') { should match(%r{\*.crit\s*?/var/log/warn}) }
    its('content') { should match(%r{\*.\*;mail.none;news.none\s*?-/var/log/messages}) }
    its('content') { should match(%r{local0,local1.\*\s*?-/var/log/localmessages}) }
    its('content') { should match(%r{local2,local3.\*\s*?-/var/log/localmessages}) }
    its('content') { should match(%r{local4,local5.\*\s*?-/var/log/localmessages}) }
    its('content') { should match(%r{local6,local7.\*\s*?-/var/log/localmessages}) }
  end

  describe service('rsyslog') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end
