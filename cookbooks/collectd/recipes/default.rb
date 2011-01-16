package 'collectd'

directory node[:collectd][:rrd_dir] do
  mode 0755
  owner "root"
  group "root"
  action :create
  recursive true
end

service "collectd" do
  name "collectd"
  supports :restart => true, :reload => true
  action :enable
end