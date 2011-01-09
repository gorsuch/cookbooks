bash "install_graphite-web" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  wget "http://launchpad.net/graphite/trunk/0.9.6/+download/graphite-web-0.9.6.tar.gz"
  tar xzf graphite-web-0.9.6.tar.gz
  rm graphite-web-0.9.6.tar.gz
  cd graphite-web-0.9.6
  python setup.py install
  cd ..
  rm -rf graphite-web-0.9.6
  EOH
end

bash "syncdb" do
  user "root"
  cwd "/opt/graphite/webapp/graphite"
  code <<-EOH
  python manage.py syncdb --noinput
  EOH
end

bash "install_local_settings" do
  user "root"
  cwd "/opt/graphite/webapp/graphite"
  code <<-EOH
  cp local_settings.py.example local_settings.py
  EOH
end

cookbook_file "/opt/graphite/webapp/graphite/graphite.wsgi" do
  source "graphite.wsgi"
  mode 0555
  owner "root"
  group "root"
end

cookbook_file "/etc/apache2/sites_enabled/001-graphite" do
  source "001-graphite"
  mode 0555
  owner "root"
  group "root"
end