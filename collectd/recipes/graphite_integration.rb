include_recipe "graphite"

bash "link_collectd_rrds" do
  user "root"
  code "ln -s #{node[:collectd][:rrd_dir]} #{node[:graphite][:rrd_dir]}/collectd"
  not_if { File.symlink?("#{node[:graphite][:rrd_dir]}/collectd") }
end