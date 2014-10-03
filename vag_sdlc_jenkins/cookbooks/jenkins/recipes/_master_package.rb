#
# Cookbook Name:: jenkins
# Recipe:: _master_package
#
# Author: Guilhem Lettron <guilhem.lettron@youscribe.com>
# Author: Seth Vargo <sethvargo@gmail.com>
#
# Copyright 2013, Youscribe
# Copyright 2014, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'debian'
  include_recipe 'apt::default'

  apt_repository 'jenkins' do
    uri          'http://pkg.jenkins-ci.org/debian'
    distribution 'binary/'
    key          'https://jenkins-ci.org/debian/jenkins-ci.org.key'
  end

  package 'jenkins' do
    version node['jenkins']['master']['version']
  end

  template '/etc/default/jenkins' do
    source   'jenkins-config-debian.erb'
    mode     '0644'
    notifies :restart, 'service[jenkins]', :immediately
  end
when 'rhel'
  include_recipe 'yum::default'

  yum_repository 'jenkins-ci' do
    baseurl 'http://pkg.jenkins-ci.org/redhat'
    gpgkey  'https://jenkins-ci.org/redhat/jenkins-ci.org.key'
  end

  package 'jenkins' do
    version node['jenkins']['master']['version']
  end

  template '/etc/sysconfig/jenkins' do
    source   'jenkins-config-rhel.erb'
    mode     '0644'
    notifies :restart, 'service[jenkins]', :immediately
  end
end

directory File.join(node['jenkins']['master']['home'], '.m2') do
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['group']
  mode '0644'
  action :create
end

template File.join(node['jenkins']['master']['home'], '.m2', 'settings.xml') do
    source   'settings.xml.erb'
    mode     '0644'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
end

template File.join(node['jenkins']['master']['home'], 'config.xml') do
    source   'config.xml.erb'
    mode     '0644'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
end

template File.join(node['jenkins']['master']['home'], 'credentials.xml') do
    source   'credentials.xml.erb'
    mode     '0644'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
end

template File.join(node['jenkins']['master']['home'], 'hudson.plugins.git.GitTool.xml') do
    source   'hudson.plugins.git.GitTool.xml.erb'
    mode     '0644'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
end

template File.join(node['jenkins']['master']['home'], 'hudson.tasks.Maven.xml') do
    source   'hudson.tasks.Maven.xml.erb'
    mode     '0644'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
end

template File.join(node['jenkins']['master']['home'], 'jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin.xml') do
    source   'jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin.xml.erb'
    mode     '0644'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-build-project-config.xml') do
    source 'SDLC-evolution-build-project-config.xml.erb'
end

jenkins_job 'SDLC-evolution-build-project' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-build-project-config.xml')
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-deploy-to-nexus-config.xml') do
    source 'SDLC-evolution-deploy-to-nexus-config.xml.erb'
end

jenkins_job 'SDLC-evolution-deploy-to-nexus' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-deploy-to-nexus-config.xml')
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-deploy-to-tomcat-config.xml') do
    source 'SDLC-evolution-deploy-to-tomcat-config.xml.erb'
end

jenkins_job 'SDLC-evolution-deploy-to-tomcat' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-deploy-to-tomcat-config.xml')
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-functional-test-config.xml') do
    source 'SDLC-evolution-functional-test-config.xml.erb'
end

jenkins_job 'SDLC-evolution-functional-test' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-functional-test-config.xml')
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-mysql-load-database-config.xml') do
    source 'SDLC-evolution-mysql-load-database-config.xml.erb'
end

jenkins_job 'SDLC-evolution-mysql-load-database' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-mysql-load-database-config.xml')
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-mysql-vagrant-halt-config.xml') do
    source 'SDLC-evolution-mysql-vagrant-halt-config.xml.erb'
end

jenkins_job 'SDLC-evolution-mysql-vagrant-halt' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-mysql-vagrant-halt-config.xml')
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-mysql-vagrant-up-config.xml') do
    source 'SDLC-evolution-mysql-vagrant-up-config.xml.erb'
end

jenkins_job 'SDLC-evolution-mysql-vagrant-up' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-mysql-vagrant-up-config.xml')
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-stress-test-config.xml') do
    source 'SDLC-evolution-stress-test-config.xml.erb'
end

jenkins_job 'SDLC-evolution-stress-test' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-stress-test-config.xml')
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-tomcat-vagrant-halt-config.xml') do
    source 'SDLC-evolution-tomcat-vagrant-halt-config.xml.erb'
end

jenkins_job 'SDLC-evolution-tomcat-vagrant-halt' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-tomcat-vagrant-halt-config.xml')
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-tomcat-vagrant-up-config.xml') do
    source 'SDLC-evolution-tomcat-vagrant-up-config.xml.erb'
end

jenkins_job 'SDLC-evolution-tomcat-vagrant-up' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-tomcat-vagrant-up-config.xml')
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-unit-test-config.xml') do
    source 'SDLC-evolution-unit-test-config.xml.erb'
end

jenkins_job 'SDLC-evolution-unit-test' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-unit-test-config.xml')
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-app-snapshot-config.xml') do
    source 'SDLC-evolution-app-snapshot-config.xml.erb'
end

jenkins_job 'SDLC-evolution-app-snapshot-test' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-app-snapshot-config.xml')
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-config-snapshot-config.xml') do
    source 'SDLC-evolution-config-snapshot-config.xml.erb'
end

jenkins_job 'SDLC-config-snapshot-test' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-config-snapshot-config.xml')
end

template File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-snapshot-config.xml') do
    source 'SDLC-evolution-snapshot-config.xml.erb'
end

jenkins_job 'SDLC-evolution-snapshot' do
    config File.join(Chef::Config[:file_cache_path], 'SDLC-evolution-snapshot-config.xml')
end

jenkins_plugin 'scm-api' do
    version '0.2'
    options '-deploy'
end

jenkins_plugin 'git-client' do
    version '1.10.2'
    options '-deploy'
end

jenkins_plugin 'git' do
    version '2.2.6'
    options '-deploy'
end

jenkins_plugin 'publish-over-ssh' do
    version '1.11'
    options '-deploy'
end

jenkins_plugin 'parameterized-trigger' do
    version '2.25'
    options '-deploy'
end

jenkins_plugin 'jquery' do
    version '1.7.2-1'
    options '-deploy'
end

jenkins_plugin 'build-pipeline-plugin' do
    version '1.4.3'
    options '-deploy'
end

jenkins_plugin 'performance' do
    version '1.11'
    options '-deploy'
end

jenkins_plugin 'ws-cleanup' do
    version '0.24'
    options '-deploy'
end

service 'jenkins' do
  supports status: true, restart: true, reload: true
  action  [:enable, :start]
end
