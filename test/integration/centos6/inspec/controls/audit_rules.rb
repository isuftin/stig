control 'auditd-rules' do
  impact 'high'
  title 'AuditD: Verify rules'
  tag 'audit'

  # Attributes
  AUDIT_RULES_FILE = input(
  'audit_rules_file',
  value: '/etc/audit/audit.rules',
  description: "The location of your auidt.rules file on the system"
  )

  AUDIT_PKG = input(
  'audit_pkg',
  value: 'audit',
  description: "The name of the package for your audit system"
  )

  AUDIT_LINES = input(
    'audit_lines',
    value: [
      '-w /etc/issue -p wa -k system-locale','-w /etc/group -p wa -k identity',
      '-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change',
      '-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change',
      '-a always,exit -F arch=b32 -S clock_settime -F a0=0 -k time-change',
      '-a always,exit -F arch=b64 -S clock_settime -F a0=0 -k time-change',
      '-w /etc/localtime -p wa -k time-change',
      '-w /etc/group -p wa -k identity',
      '-w /etc/passwd -p wa -k identity',
      '-w /etc/gshadow -p wa -k identity',
      '-w /etc/shadow -p wa -k identity',
      '-w /etc/security/opasswd -p wa -k identity',
      '-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale',
      '-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale',
      '-w /etc/issue -p wa -k system-locale',
      '-w /etc/issue.net -p wa -k system-locale',
      '-w /etc/hosts -p wa -k system-locale',
      '-w /etc/sysconfig/network -p wa -k system-locale',
      '-w /etc/selinux/ -p wa -k MAC-policy',
      '-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod',
      '-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod',
      '-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod',
      '-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod',
      '-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod',
      '-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod',
      '-a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access',
      '-a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access',
      '-a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access',
      '-a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access',
      '-a always,exit -F path=/bin/ping -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged',
      '-a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k export',
      '-a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k export',
      '-w /etc/sudoers -p wa -k actions',
      '-w /var/log/faillog -p wa -k logins',
      '-w /var/log/lastlog -p wa -k logins',
      '-w /var/log/btmp -p wa -k logins',
      '-w /var/run/utmp -p wa -k session',
      '-w /var/log/wtmp -p wa -k logins',
      '-a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k mounts',
      '-a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k mounts',
      '-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete',
      '-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete',
      '-w /var/log/sudo.log -p wa -k actions',
      '-w /sbin/insmod -p x -k modules',
      '-w /sbin/rmmod -p x -k modules',
      '-w /sbin/modprobe -p x -k modules',
      '-a always,exit -F arch=b64 -S init_module -S delete_module -k modules',
      '-b 8192',
      '-f 1',
      '-D'
    ],
    description: "The lines that you want to be in your auitd configuration."
  )

  only_if do
    package(AUDIT_PKG).installed?
  end

  describe file(AUDIT_RULES_FILE) do
    it { should exist }
    it { should be_file }
    its('mode') { should cmp '0640' }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end

  # The 'line' var is is wrapped in a #{} so that the reporting will output each
  # line that is tested in the results.
  AUDIT_LINES.each do |line|
    describe file(AUDIT_RULES_FILE) do
      its('content') { should match(%r{#{line}}) }
    end
  end

end
