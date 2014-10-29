#
# Cookbook Name:: flyway
# Recipe:: default
#
# Copyright 2014 Juan Larriba
#
#

download_url = File.join(node['flyway']['base_url'], node['flyway']['filename'], node['flyway']['version'], node['flyway']['filename'] + '-' + node['flyway']['version'] + '.tar.gz')

# Download Flyway
remote_file "#{Chef::Config[:file_cache_path]}/#{node['flyway']['filename']}.tar.gz" do
  source download_url
  action :create
  notifies :run, 'bash[Extract Flyway]', :immediately
end

bash 'Extract Flyway' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar xzf #{node['flyway']['filename']}.tar.gz -C #{node['flyway']['installation_dir']}
  chown #{node['flyway']['user']}:#{node['flyway']['group']} -R #{node['flyway']['installation_dir']}/flyway-#{node['flyway']['version']}
  EOF
end

link File.join(node['flyway']['installation_dir'], 'flyway') do
  to File.join(node['flyway']['installation_dir'], "flyway-#{node['flyway']['version']}")
end

template File.join(node['flyway']['installation_dir'], "flyway-#{node['flyway']['version']}", 'conf', 'flyway.properties') do
  source 'flyway.properties.erb'
  mode '0644'
  owner node['flyway']['user']
  group node['flyway']['group']
  variables({
    :dburl => node['flyway']['dburl'],
    :dbuser => node['flyway']['dbuser'],
    :dbpassword => node['flyway']['dbpassword']
  })
end
