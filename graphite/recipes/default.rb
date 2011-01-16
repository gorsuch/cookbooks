include_recipe "python::cairo"
include_recipe "python::django"

include_recipe "apache2"
include_recipe "apache2::mod_wsgi"

user node[:graphite][:carbon_user] do
  comment "carbon account"
  system true
  shell "/bin/false"
end

[:log_dir, :lists_dir, :rrd_dir, :whisper_dir].each do |dir|
   directory node[:graphite][dir] do
      mode 0775
      owner node[:graphite][:carbon_user]
      group "root"
      action :create
      recursive true
   end
end

[:db_dir, :log_dir].each do |dir|
   directory node[:graphite][dir] do
      mode 0775
      owner "www-data"
      group "www-data"
      action :create
      recursive true
   end
end

Directory node[:graphite][:deb_cache] do
  action :create
end

remote_file "#{node[:graphite][:deb_cache]}/python-whisper_#{node[:graphite][:graphite_deb_version]}.deb" do
  source "#{node[:graphite][:deb_source]}/python-whisper_#{node[:graphite][:graphite_deb_version]}.deb"
end

remote_file "#{node[:graphite][:deb_cache]}/python-carbon_#{node[:graphite][:graphite_deb_version]}.deb" do
  source "#{node[:graphite][:deb_source]}/python-carbon_#{node[:graphite][:graphite_deb_version]}.deb"
end

remote_file "#{node[:graphite][:deb_cache]}/python-graphite-web_#{node[:graphite][:graphite_deb_version]}.deb" do
  source "#{node[:graphite][:deb_source]}/python-graphite-web_#{node[:graphite][:graphite_deb_version]}.deb"
end

dpkg_package "python-whisper" do
  source "#{node[:graphite][:deb_cache]}/python-whisper_#{node[:graphite][:graphite_deb_version]}.deb"
end

dpkg_package "python-carbon" do
  source "#{node[:graphite][:deb_cache]}/python-carbon_#{node[:graphite][:graphite_deb_version]}.deb"
end

dpkg_package "python-graphite-web" do
  source "#{node[:graphite][:deb_cache]}/python-graphite-web_#{node[:graphite][:graphite_deb_version]}.deb"
end

template "#{node[:graphite][:dir]}/conf/carbon.conf" do
  source "carbon.conf.erb"
  mode 0644
  owner "root"
  group "root"
end

template "#{node[:graphite][:dir]}/conf/storage-schemas.conf" do
  source "storage-schemas.conf.erb"
  mode 0644
  owner "root"
  group "root"
end

template "/etc/init/carbon.conf" do
  source "carbon-upstart.conf.erb"
  mode 0644
  owner "root"
  group "root"
end

template "#{node[:graphite][:dir]}/webapp/graphite/settings.py" do
  source "settings.py.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[apache2]"
end

template "#{node[:graphite][:dir]}/webapp/graphite/graphite.wsgi" do
  source "graphite.wsgi.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[apache2]"
end

# the next action is really, really cheap.  Please replace.
template "/etc/apache2/sites-enabled/001-graphite" do
  source "graphite-vhost.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[apache2]"
end

bash "syncdb" do
  not_if {File.exists?("#{node[:graphite][:db_name]}")}
  user "root"
  cwd "#{node[:graphite][:dir]}/webapp/graphite"
  code <<-EOH
  python manage.py syncdb --noinput
  chown -R www-data:www-data /data/db/graphite.db
  EOH
end

service "carbon" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end