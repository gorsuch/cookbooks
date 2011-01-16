# inspired (with a few corrections) by https://github.com/37signals/37s_cookbooks/blob/master/apache2/definitions/apache_site.rb
define :apache_site, :enable => true, :number => "000" do
  include_recipe "apache2"

  if params[:enable]
    execute "a2ensite #{params[:name]}" do
      command "/usr/sbin/a2ensite #{params[:name]}"
      notifies :restart, resources(:service => "apache2")
      only_if { File.exists?("#{node[:apache][:dir]}/sites-available/#{params[:name]}") }
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