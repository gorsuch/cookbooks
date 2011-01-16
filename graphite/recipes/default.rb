include_recipe "python::cairo"
include_recipe "python::django"
include_recipe "python::rrdtool"

include_recipe "apache2"
include_recipe "apache2::mod_wsgi"

user node[:graphite][:carbon_user] do
  comment "carbon account"
  system true
  shell "/bin/false"
end

[:log_dir, :lists_dir, :rrd_dir, :whisper_dir].each do |dir|
   directory node[:graphite][dir] do
      mode 0775
      owner node[:graphite][:carbon_user]
      group "root"
      action :create
      recursive true
   end
end

[:db_dir, :log_dir].each do |dir|
   directory node[:graphite][dir] do
      mode 0775
      owner "www-data"
      group "www-data"
      action :create
      recursive true
   end
end

Directory node[:graphite][:deb_cache] do
  action :create
end

include_recipe "graphite::whisper"
include_recipe "graphite::carbon"
include_recipe "graphite::web"