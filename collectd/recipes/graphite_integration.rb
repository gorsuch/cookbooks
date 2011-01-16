include_recipe "graphite"

link node[:collectd][:rrd_dir] do
  to "#{node[:graphite][:rrd_dir]}/collectd"
end