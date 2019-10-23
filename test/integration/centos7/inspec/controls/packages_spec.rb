control 'packages' do
  impact 'low'
  title 'ensure packages are installed or not'
  tag 'packages'
  DISABLED_PKGS = input(
    'disabled_pkgs',
    value: ['dhcp'],
    description: "The list of packages that we want to ensure are not installed"
  )

  ENABLED_PKGS = input(
    'enabled_pkgs',
    value: ['tcp_wrappers'],
    description: "The list of packages that we want to ensure are not installed"
  )

  only_if do
    DISABLED_PKGS.any?
  end

  DISABLED_PKGS.each do |pkg|
    describe package(pkg) do
      it { should_not be_installed }
    end
  end

  only_if do
    ENABLED_PKGS.any?
  end

  ENABLED_PKGS.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end
