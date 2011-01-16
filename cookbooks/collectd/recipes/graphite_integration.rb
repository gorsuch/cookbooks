include_recipe "graphite"

template "#{node[:collectd][:dir]}/collectd.conf" do
  source "collectd.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[collectd]"
end

template "#{node[:collectd][:dir]}/collection.conf" do
  source "collection.conf.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[collectd]"
end