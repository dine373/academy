#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "httpd" do
 action :install
end

service "httpd" do
 action [ :enable, :start]
end

node.default["apache"]["indexfile"] = "index2.html"
cookbook_file "/var/www/html/index.html" do 
# source "index.html"
# source node["apache"]["indexfile"]
  source node["apache"]["indexfile"]
  mode "0644"
end


execute "mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.disabled" do
 only_if do
  File.exist?("/etc/httpd/conf.d/welcome.com")
 end
 notifies :restart, "service[httpd]"
end



#package "haproxy" do
# action :install
#end
#
#template "/etc/haproxy/haproxy.conf" do
# source "haproxy.cfg.erb"
# owner "root"
# group "root"
# mode "0644"
# notifies :restart, "service[haproxy]"
#end

#service "haproxy" do
# supports :restart => :true
# action [:enable, :start]
#end

