package "apache2" do
  name "apache2"
end

service "apache2" do
  name "apache2"
  supports :restart => true, :reload => true
  action :enable
end

service "apache2" do
  action :start
end

apache_site "default" do
  enable false
end