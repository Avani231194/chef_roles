#
# Cookbook:: nexus
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


package %w(java-1.8.0-openjdk.x86_64 wget) do 
 action :install
end

directory "#{node['nexus']['dirname']}" do
  owner 'root'
  group 'root'
  mode '0755'
  not_if { Dir.exist?("#{node['nexus']['dirname']}") }
   action :create
end



user 'nexus' do
 home '/home/nexus'
 shell '/bin/bash'
 not_if  'grep nexus /etc/passwd', :user => 'nexus'
 action :create
end



nexus_tar 'nexus_install' do
title 'nexus'
end


template "#{node['nexus']['o_path']}/nexus.rc" do
 source 'nexus.rc.erb'
 not_if do ! File.exist?("#{node['nexus']['o_path']}/nexus.rc" ) end
 action :create
end

template "#{node['nexus']['path']}/nexus.vmoptions" do
 source 'nexus.vmoptions.erb'
  variables({
      :datapath => "#{node['nexus']['datapath']}"
     }) 
 not_if do ! File.exist?("#{node['nexus']['path']}/nexus.vmoptions" ) end
 action :create
end

link '/etc/init.d/nexus' do
  to '/app/nexus/bin/nexus'
 link_type :symbolic
  action :create
end

execute 'chkconfig' do
command <<-EOH
 sudo chkconfig --add nexus
 sudo chkconfig --levels 345 nexus on
EOH
end

service 'nexus' do
action :start
end
