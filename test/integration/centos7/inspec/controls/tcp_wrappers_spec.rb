control 'tcp-wrappers' do
  impact 'medium'
  title 'fstab: ensure tcp wrappers installed'
  tag 'tcpwrappers'
  describe package('tcp_wrappers') do
    it { should be_installed }
  end
end
