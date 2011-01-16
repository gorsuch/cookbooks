remote_file "#{node[:graphite][:deb_cache]}/python-graphite-web_#{node[:graphite][:graphite_deb_version]}.deb" do
  source "#{node[:graphite][:deb_source]}/python-graphite-web_#{node[:graphite][:graphite_deb_version]}.deb"
end

dpkg_package "python-graphite-web" do
  source "#{node[:graphite][:deb_cache]}/python-graphite-web_#{node[:graphite][:graphite_deb_version]}.deb"
end

template "#{node[:graphite][:dir]}/webapp/graphite/local_settings.py" do
  source "local_settings.py.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[apache2]"
end

template "#{node[:graphite][:dir]}/webapp/graphite/graphite.wsgi" do
  source "graphite.wsgi.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[apache2]"
end

template "#{node[:apache][:dir]}/sites-available/graphite" do
  source "graphite-vhost.erb"
  mode 0644
  owner "root"
  group "root"
end

apache_site "graphite"

bash "syncdb" do
  not_if {File.exists?("#{node[:graphite][:db_name]}")}
  user "root"
  cwd "#{node[:graphite][:dir]}/webapp/graphite"
  code <<-EOH
  python manage.py syncdb --noinput
  chown -R www-data:www-data /data/db/graphite.db
  EOH
end
