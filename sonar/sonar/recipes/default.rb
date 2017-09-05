#
# Cookbook:: sonar
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


package 'wget' do
action :install
end

rpm_package 'mysql' do
source 'http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm'
action :install
end

execute 'update' do
command 'yum update -y'
end

package %w(mysql-server java-1.8.0-openjdk)do
  action :install
end

control_group 'mysql' do
  control 'mysql pacakge' do
    it 'should be installed' do
      expect(package('mysql-server')).to be_installed
    end
  end
end

control_group 'java' do
  control 'mysql java' do
    it 'should be installed' do
      expect(package('java-1.8.0-openjdk')).to be_installed
    end
  end
end




service 'mysqld' do
action :start
end

include_recipe 'sonar::mysql_secure_install'

sonar_install 'sonar_install' do
title 'Installing sonar'
end

template "#{node['sonar']['property_path']}/sonar.properties" do
  source 'sonar.properties.erb'
 variables({
      :username => "#{node['sonar']['name']}" ,
      :password => "#{node['sonar']['pass']}" ,
      :context => "#{node['sonar']['context']}" 
     }) 
  mode '0755'
end


#execute 'script' do
#cwd '/opt/sonarqube/bin/linux-x86-64'
#command 'sudo ./sonar.sh start'
#end


template "#{node['sonar']['service']}/sonar" do
  source 'sonar.erb'
  mode '0755'
 #not_if do ! File.exist?("#{node['sonar']['service']}/sonar" ) end
end

link '/usr/bin/sonar' do
to '/opt/sonarqube/bin/linux-x86-64/sonar.sh'
link_type :symbolic
action  :create
end

execute 'chkconfig' do
command 'sudo chkconfig --add sonar'
end

service 'sonar' do
  action 'start'
end



