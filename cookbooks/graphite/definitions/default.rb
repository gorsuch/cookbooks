define :graphite_rrd, :enable => true do
  include_recipe "graphite"

  if params[:enable]
    execute "a2ensite #{params[:name]}" do
      command "/usr/sbin/a2ensite #{params[:name]}"
      notifies :restart, resources(:service => "apache2")
      only_if { File.exists?("#{params[:name]}") }
      not_if  { File.symlink?("#{node[:apache][:dir]}/sites-enabled/#{params[:name]}")  }
    end
  else
    execute "a2dissite #{params[:name]}" do
      command "/usr/sbin/a2dissite #{params[:name]}"
      notifies :restart, resources(:service => "apache2")
      only_if do 
        File.symlink?("#{node[:apache][:dir]}/sites-enabled/#{params[:name]}") || File.symlink?("#{node[:apache][:dir]}/sites-enabled/#{params[:number]}-#{params[:name]}") 
      end
    end
  end
end