#
# Cookbook:: grafana
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


rpm_package 'grafanaa' do
source 'https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-4.4.2-1.x86_64.rpm' 
action :install
end


yum_package %w( initscripts fontconfig  urw-fonts ) do
action :install
end

package 'grafana' do
action :install
end


service 'grafana-server' do
action :start
end

execute 'configure' do
command 'sudo /sbin/chkconfig --add grafana-server'
end


service 'daemon-reload'do 
   action :reload
end
 service 'grafana-server' do
   action [ :enable, :start ]
end
