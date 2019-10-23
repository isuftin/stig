control 'su-restriction' do
  impact 'medium'
  title 'su-restriction: PAM restrictions'
  tag 'su-restriction'
  describe file('/etc/pam.d/su') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
  end
end
