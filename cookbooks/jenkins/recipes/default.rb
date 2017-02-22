#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# package 'jenkins' do
# action :install
# #end
#
# case node['platform']
# when 'centos'
#
# execute "install jenkins" do
#  command "sudo yum install -y java-1.8"
#  command 'sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo'
#  command 'sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key'
#  command 'sudo yum install -y jenkins'
# end
# when 'ubuntu'
#
# execute "install enkins" do
#  command "apt-get install -y default-jre"
#  command "wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -"
#  command "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'"
#  command "sudo apt-get update && sudo apt-get install jenkins"
# end
# end

# centos :6.7
# execute 'install java' do
#  command 'yum install -y java-1.7.0-openjdk-devel'
# end

# yum_repository 'jenkins' do
# description "jenkins custom repo"
# baseurl "http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo"
# gpgkey "https://jenkins-ci.org/redhat/jenkins-ci.org.key"
# action :create
# end

# execute 'installjenkins' do
# command "yum install jenkins"
# end

# yum_repository 'jenkins' do
# action :delete
# end
#

# centos
case node['platform']
# Installation  of Jenkins for Centos Platform
when 'centos'
  # java = '1.8.0'
  execute 'install java' do
    command "yum install -y java-#{node['jenkins']['java']['version']}-openjdk-devel"
    # command "yum install -y java-#{java}-openjdk-devel"
  end

  cookbook_file 'jenkinsrepo' do
    source 'jenkins.repo'
    path '/etc/yum.repos.d/jenkins.repo'
    owner 'root'
    group 'root'
    mode '644'
    not_if { File.exist? '/etc/yum.repos.d/jenkins.repo' }
    notifies :run, 'execute[import jenkins key]', :immediate
  end

  execute 'import jenkins key' do
    command ' rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key '
    action :nothing
  end

  package 'jenkins' do
    action :install
    only_if { File.exist? '/usr/bin/java' }
  end

  service 'jenkins' do
    action [:start, :enable]
  end

  # Change Jeinstalling jenkins using chefinstalling jenkins using chefinstalling jenkins using chefnkins Port if required
  execute 'change Port 8081' do
    command "sed -i 's/8080/#{node['jenkins']['config']['port']}/g' /etc/sysconfig/jenkins"
    only_if "node['jenkins']['config']['change']"
    notifies :restart, 'service[jenkins]'
  end

# Installation of Jenkins for Ubuntu Platform
when 'ubuntu'
  execute 'install java' do
    command 'apt-get install -y openjdk-7-jre'
  end

  cookbook_file 'jenkinsrepo' do
    source 'jenkins.list'
    path '/etc/apt/sources.list.d/jenkins.list'
    owner 'root'
    group 'root'
    mode '644'
    not_if { File.exist? '/etc/apt/sources.list.d/jenkins.list' }
    notifies :run, 'execute[Add repo]', :immediate
  end
  execute 'Add repo' do
    command 'wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add - ' && 'apt-get update '
    action :nothing
    # notifies :run, 'execute[install jenkins]', :immediate
  end

  execute 'install jenkins' do
    command 'apt-get update && apt-get -y install jenkins --force-yes'
  end

  service 'jenkins' do
    action [:start, :enable]
  end

  execute 'change Port 8081' do
    # command "sed -i 's/8080/#{node['jenkins']['config']['port']}/g' /etc/default/jenkins"
    command "sed -i '/HTTP_PORT=8080\c/#{node['jenkins']['config']['port']}' /etc/default/jenkins"
    only_if "node['jenkins']['config']['change']"
    notifies :restart, 'service[jenkins]'
  end

end
