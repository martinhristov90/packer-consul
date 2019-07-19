control 'consul_systemd' do
    title 'consul_check_systemd'
    desc 'Checks if Consul is installed as Systemd service'
    
    describe systemd_service('consul') do
        it { should be_installed }
        it { should_not be_enabled }
        it { should_not be_running }
    end
end