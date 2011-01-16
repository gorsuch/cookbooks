remote_file "#{node[:graphite][:deb_cache]}/python-whisper_#{node[:graphite][:whisper_deb_version]}.deb" do
  source "#{node[:graphite][:deb_source]}/python-whisper_#{node[:graphite][:whisper_deb_version]}.deb"
end

dpkg_package "python-whisper" do
  source "#{node[:graphite][:deb_cache]}/python-whisper_#{node[:graphite][:whisper_deb_version]}.deb"
end