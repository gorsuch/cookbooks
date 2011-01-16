include_recipe "graphite"

template "#{node[:collectd][:dir]}/collectd.conf" do
  source "collectd.conf.erb"
  mode 0644
  owner "root"
  group "root"
end

template "#{node[:collectd][:dir]}/collection.conf" do
  source "collection.conf.erb"
  mode 0644
  owner "root"
  group "root"
end


bash "link_collectd_rrds" do
  user "root"
  code "ln -s #{node[:collectd][:rrd_dir]} #{node[:graphite][:rrd_dir]}/collectd"
  not_if { File.symlink?("#{node[:graphite][:rrd_dir]}/collectd") }
end