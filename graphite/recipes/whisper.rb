bash "install_whisper" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  wget "http://launchpad.net/graphite/trunk/0.9.6/+download/whisper-0.9.6.tar.gz"
  tar xzf whisper-0.9.6.tar.gz
  rm whisper-0.9.6.tar.gz
  cd whisper-0.9.6
  python setup.py install
  cd ..
  rm -rf whisper-0.9.6
  EOH
end