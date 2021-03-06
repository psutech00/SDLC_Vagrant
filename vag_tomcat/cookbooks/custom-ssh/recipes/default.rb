#
# Cookbook Name:: custom-ssh
# Recipe:: default
#
# Copyright 2014 Juan Larriba
#


template '/etc/ssh/sshd_config' do
    source 'sshd_config.erb'
    user   'root'
    group  'root'
    mode   '0600'
    #notifies :restart, 'service[sshd]', :immediately
  end

service 'sshd' do
  action  [:restart]
end


