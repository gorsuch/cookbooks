package 'collectd'

service "collectd" do
  name "collectd"
  supports :restart => true, :reload => true
  action :enable
end