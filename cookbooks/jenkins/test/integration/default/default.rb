require 'chefspec'

describe 'file::create' do
	let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.1').converge(described_recipe)}

	it 'creates jenkins repo file' do
		expect(chef_run).to create_file('/etc/yum.repos.d/jenkins.repo')
		expect(chef_run).to_not create_file('/etc/yum.repos.d/jenkins.repo')
	end
end

describe 'execute::run' do 
	let (:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.1').converge(described_recipe)}

	it 'runs a execute of install java' do
		expect(chef_run).to run_execute('install java')
	end
end

