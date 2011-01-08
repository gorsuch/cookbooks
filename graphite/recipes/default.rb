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
  rm whisper-0.9.6.tar.gz
  cd whisper-0.9.6
  python setup.py install
  cd ..
  rm -rf whisper-0.9.6
  EOH
end

bash "install_carbon" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  wget "http://launchpad.net/graphite/trunk/0.9.6/+download/carbon-0.9.6.tar.gz"
  tar xzf carbon-0.9.6.tar.gz
  rm carbon-0.9.6.tar.gz
  cd carbon-0.9.6
  python setup.py install
  cd ..
  rm -rf carbon-0.9.6
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

bash "install_graphite-web" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  wget "http://launchpad.net/graphite/trunk/0.9.6/+download/graphite-web-0.9.6.tar.gz"
  tar xzf graphite-web-0.9.6.tar.gz
  rm graphite-web-0.9.6.tar.gz
  cd graphite-web-0.9.6
  python setup.py install
  cd ..
  rm -rf graphite-web-0.9.6
  EOH
end

bash "syncdb" do
  user "root"
  cwd "/opt/graphite/webapp/graphite"
  code <<-EOH
  python manage.py syncdb --noinput
  EOH
end

bash "install_local_settings" do
  user "root"
  cwd "/opt/graphite/webapp/graphite"
  code <<-EOH
  cp local_settings.py.example local_settings.py
  EOH
end

bash "start_carbon" do
  user "root"
  cwd "/opt/graphite/"
  code <<-EOH
  ./bin/carbon-cache.py start
  EOH
end