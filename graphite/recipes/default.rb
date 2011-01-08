#
# Cookbook Name:: graphite
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "python-cairo"
package "python-django"
package "libapache2-mod-wsgi"

include_recipe "graphite::whisper"
include_recipe "graphite::carbon"
include_receipt "graphite::web"

bash "start_carbon" do
  user "root"
  cwd "/opt/graphite/"
  code <<-EOH
  ./bin/carbon-cache.py start
  EOH
end