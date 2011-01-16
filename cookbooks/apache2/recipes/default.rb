#
# Cookbook Name:: apache2
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "apache2" do
  name "apache2"
end

service "apache2" do
  name "apache2"
  supports :restart => true, :reload => true
  action :enable
end

service "apache2" do
  action :start
end

apache_site "default" do
  enable false
end