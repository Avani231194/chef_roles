bash 'user-create' do
  code <<-EOH
  mysql -u root -e "CREATE DATABASE #{node['mysql']['db_name']};"
  mysql -u root -e "CREATE USER #{node['mysql']['name']} IDENTIFIED BY #{node['mysql']['password']};"
  mysql -u root -e "GRANT ALL ON #{node['mysql']['db_name']}.* TO \"#{node['mysql']['name']}\";"
  mysql -u root -e "FLUSH PRIVILEGES;"
EOH
end


