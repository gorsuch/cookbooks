#
# Cookbook Name:: graphite
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "python::cairo"
include_recipe "python::django"

include_recipe "apache2"
include_recipe "apache2::mod_wsgi"

[node[:graphite][:log_dir] node[:graphite][:lists_dir] node[:graphite][:log_dir] node[:graphite][:rrd_dir] node[:graphite][:whisper_dir]].each do |dir|
   directory "/data/#{dir}" do
      mode 0775
      owner "carbon"
      group "root"
      action :create
      recursive true
   end
end

bash "install_whisper" do
  not_if {File.exists?('/usr/local/lib/python2.6/dist-packages/whisper.py')}
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
  not_if {File.exists?('/opt/graphite/bin/carbon-cache.py')}
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

template "/opt/graphite/conf/carbon.conf" do
  source "carbon.conf.erb"
  mode 0444
  owner "root"
  group "root"
end

template "/opt/graphite/conf/storage-schemas.conf" do
  source "storage-schemas.conf.erb"
  mode 0444
  owner "root"
  group "root"
end

template "/etc/init/carbon.conf" do
  source "carbon-upstart.conf.erb"
  mode 0444
  owner "root"
  group "root"
end

bash "install_graphite" do
  not_if {File.exists?('/opt/graphite/webapp')}
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

template "/opt/graphite/webapp/graphite/settings.py" do
  source "settings.py.erb"
  mode 0444
  owner "root"
  group "root"
end

template "/opt/graphite/webapp/graphite/graphite.wsgi" do
  source "graphite.wsgi.erb"
  mode 0444
  owner "root"
  group "root"
end

template "/etc/apache2/sites-enabled/001-graphite" do
  source "graphite-vhost.erb"
  mode 0444
  owner "root"
  group "root"
  notifies :restart, "service[apache2]"
end

user "carbon" do
  comment "carbon account"
  system true
  shell "/bin/false"
end

%w{db log/webapp}.each do |dir|
   directory "/data/#{dir}" do
      mode 0775
      owner "www-data"
      group "www-data"
      action :create
      recursive true
   end
end

bash "syncdb" do
  not_if {File.exists?('/data/db/graphite.db')}
  user "root"
  cwd "/opt/graphite/webapp/graphite"
  code <<-EOH
  python manage.py syncdb --noinput
  EOH
end

bash "set_db_perms" do
  not_if {File.exists?('/data/db/graphite.db')}
  user "root"
  cwd "/"
  code "chown -R www-data:www-data /data/db/graphite.db"
end

service "carbon" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end