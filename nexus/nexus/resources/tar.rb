property :title
action :start do

bash 'download_install' do
cwd '/app'
code <<-EOH
sudo wget https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-3.0.2-02-unix.tar.gz
sudo tar -xvf nexus-3.0.2-02-unix.tar.gz 
sudo mv nexus-3.0.2-02 nexus
sudo chown -R nexus:nexus /app/nexus
EOH
end
end
