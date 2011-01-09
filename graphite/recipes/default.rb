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
package "libapache2-mod-wsgi"

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

cookbook_file "/opt/graphite/conf/carbon.conf" do
  source "carbon.conf"
  mode 0555
  owner "root"
  group "root"
end

cookbook_file "/opt/graphite/conf/storage-schemas.conf" do
  source "storage-schemas.conf"
  mode 0555
  owner "root"
  group "root"
end

bash "install_graphite" do
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

directory "/opt/graphite/storage/" do
  owner "www-data"
  group "www-data"
  recursive true
end


bash "syncdb" do
  user "root"
  cwd "/opt/graphite/webapp/graphite"
  code <<-EOH
  python manage.py syncdb --noinput
  EOH
end

cookbook_file "/opt/graphite/webapp/graphite/local_settings.py" do
  source "local_settings.py"
  mode 0555
  owner "root"
  group "root"
end

cookbook_file "/opt/graphite/webapp/graphite/graphite.wsgi" do
  source "graphite.wsgi"
  mode 0555
  owner "root"
  group "root"
end

cookbook_file "/etc/apache2/sites-enabled/001-graphite" do
  source "apache-graphite"
  mode 0555
  owner "root"
  group "root"
end

bash "start_carbon" do
  user "root"
  cwd "/opt/graphite/"
  code <<-EOH
  ./bin/carbon-cache.py start
  EOH
end