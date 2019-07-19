control 'consul_user' do
    title 'consul_user_check'
    desc 'Checks if user consul is available'

    describe group('consul') do
      it { should exist }
    end
    
    describe user('consul') do
        it { should exist }
        its('shell') { should eq '/bin/false' }
        its('group') { should eq 'consul' }
        its('home')  { should eq '/etc/consul.d' }
      end
end