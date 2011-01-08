#
# Cookbook Name:: graphite
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "python-cairo"
package "python-django"

bash "install_whisper" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  wget "http://launchpad.net/graphite/trunk/0.9.6/+download/whisper-0.9.6.tar.gz"
  tar xzf whisper-0.9.6.tar.gz
  cd whisper-0.9.6
  python setup.py install
  EOH
end

bash "install_carbon" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  wget "http://launchpad.net/graphite/trunk/0.9.6/+download/carbon-0.9.6.tar.gz"
  tar xzf carbon-0.9.6.tar.gz
  cd carbon-0.9.6
  python setup.py install
  EOH
end

bash "configure_carbon" do
  user "root"
  cwd "/opt/graphite/conf"
  code <<-EOH
  cp carbon.conf.example carbon.conf
  cp storage-schemas.conf.example storage-schemas.conf
  EOH
end

bash "configure_graphite_web" do
  user "root"
  cwd "/opt/graphite/conf"
  code <<-EOH
  cp carbon.conf.example carbon.conf
  cp storage-schemas.conf.example storage-schemas.conf
  EOH
end

