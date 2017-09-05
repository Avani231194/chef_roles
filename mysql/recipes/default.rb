#
# Cookbook:: mysql
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.



rpm_package 'mysql-server' do
  source 'http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm'
  action :install
end

yum_package 'mysql-server' do
  action :install
end

#execute 'update' do
#command 'yum update -y'
#end

service 'mysqld' do
  action  :start
end

include_recipe 'mysql::secure_install'
