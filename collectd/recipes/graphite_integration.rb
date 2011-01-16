include_recipe "graphite"
include_recipe "collectd"

bash "link_collectd_rrds" do
  user "root"
  code "ln -s #{node[:collectd][:rrd_dir]} #{node[:graphite][:rrd_dir]}/collectd"
end