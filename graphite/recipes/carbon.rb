bash "install_carbon" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  wget "http://launchpad.net/graphite/trunk/0.9.6/+download/carbon-0.9.6.tar.gz"
  tar xzf carbon-0.9.6.tar.gz
  rm carbon-0.9.6.tar.gz
  cd carbon-0.9.6
  python setup.py install
  cd ..
  rm -rf carbon-0.9.6
  EOH
end

bash "configure_carbon" do
  user "root"
  cwd "/opt/graphite/conf"
  code <<-EOH
  cp carbon.conf.example carbon.conf
  cp storage-schemas.conf.example storage-schemas.conf
  EOH
end
