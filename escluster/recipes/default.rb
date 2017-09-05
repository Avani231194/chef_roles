#
# Cookbook:: escluster
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe "java::default"

execute 'Adding elasticsearch public Key' do
  command 'rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch'
  action :run
end

cookbook_file 'copy file' do
  path '/etc/yum.repos.d/elasticsearch.repo'
  source 'elasticsearch.repo'
end

execute 'Cleaning Packages' do
  command 'yum clean all'
  action :run
end

package 'elasticsearch' do
  flush_cache before: true
  action :install
end

template 'Adding elasticsearch cluster Conf File' do
  path '/etc/elasticsearch/elasticsearch.yml'
  source 'elasticsearch.yml.erb'
  variables(
    :hostip => "#{node['escluster']['hostip']}",
    :nodename => "#{node['escluster']['nodename']}",
    :master => "#{node['escluster']['master']}",
    :data => "#{node['escluster']['data']}",
    :masterip => "#{node['escluster']['masterip']}",
    :dataip => "#{node['escluster']['dataip']}",
    :clientip => "#{node['escluster']['clientip']}",
    :clustername => "#{node['escluster']['clustername']}"
    )
  notifies :restart, 'service[elasticsearch]', :immediately
end

template 'Adding elasticsearch cluster JVM File' do
  path '/etc/elasticsearch/jvm.options'
  source 'jvm.options.erb'
  notifies :restart, 'service[elasticsearch]', :immediately
end

service 'elasticsearch' do
 action [:enable, :start]
end
