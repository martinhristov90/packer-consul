control 'consul_install' do
    title 'consul_install_check'
    desc 'Checks if Consul is installed'
    
    describe command('consul') do
        it { should exist }
    end

    describe command('consul-template') do
        it { should exist }
    end

    describe command('envconsul') do
        it { should exist }
    end

    
end