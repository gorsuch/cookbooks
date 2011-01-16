remote_file "#{node[:graphite][:deb_cache]}/python-carbon_#{node[:graphite][:carbon_deb_version]}.deb" do
  source "#{node[:graphite][:deb_source]}/python-carbon_#{node[:graphite][:carbon_deb_version]}.deb"
end

dpkg_package "python-carbon" do
  source "#{node[:graphite][:deb_cache]}/python-carbon_#{node[:graphite][:carbon_deb_version]}.deb"
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

service "carbon" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end