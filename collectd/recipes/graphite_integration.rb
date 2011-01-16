include_recipe "graphite"

bash "link_collectd_rrds" do
  user "root"
  code "ln -s /var/lib/collectd/rrd /data/rrd/collectd"
end