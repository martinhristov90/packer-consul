control 'consul_directory' do
    title 'consul_directory_check'
    desc 'Checks if Consul directory is created and has the right permissions'
    
    describe directory('/etc/consul.d/') do
        it { should exist }
        its('owner') { should eq 'consul' }
        its('mode')  { should cmp '0755' }
    end

    describe file('/etc/consul.d/consul.hcl') do
        it { should exist }
        its('owner') { should eq 'consul' }
        its('mode')  { should cmp '0640' }
        its('size')  { should eq 0 }
      end
end
    