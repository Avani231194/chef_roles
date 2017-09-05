bash 'extract_module' do
  code <<-EOH
mysql -u root -e "CREATE USER '#{node['sonar']['name']}'@'localhost' IDENTIFIED BY '#{node['sonar']['pass']}';"
mysql -u root -e "CREATE DATABASE #{node['sonar']['name']};"
mysql -u root -e "GRANT ALL PRIVILEGES ON #{node['sonar']['name']}.* TO '#{node['sonar']['name']}'@'localhost';"
mysql -u root -e "flush privileges;"
EOH
end
