#
# Cookbook Name:: site-cookbooks/initial
# Recipe:: default
#
# Copyright (C) 2014 Giuseppe Rota
#
# All rights reserved - Do Not Redistribute
if node['initial'].nil?
  Chef::Application.fatal! "You must set the node['initial'] attribute in chef-solo mode."
end

include_recipe "apt::default"
# required by rvm
package "gawk"
include_recipe "git::default"
include_recipe "php"
include_recipe "mysql::server"
include_recipe "mysql::client"

#include_recipe "apache2"
#ruby_block "fix apache2 2.4 cookbook incompatibility, apache2.conf" do
  #block do
    #rc = Chef::Util::FileEdit.new("#{node['apache']['dir']}/apache2.conf")
    #rc.search_file_replace_line(/^LockFile \/var\//, 'Mutex file:/var/')
    #rc.search_file_replace_line(/^DefaultType/, '')
    #rc.insert_line_if_no_match(/^ServerName/, 'ServerName localhost')
    #rc.write_file
  #end
  #subscribes :run, "template[apache2.conf]", :immediately
  #action :nothing
#end
#ruby_block "fix apache2 2.4 cookbook incompatibility, ports.conf" do
  #block do
    #rc = Chef::Util::FileEdit.new("#{node['apache']['dir']}/ports.conf")
    #rc.search_file_delete(/^NameVirtualHost/)
    #rc.write_file
  #end
  #subscribes :run, "template[ports.conf]", :immediately
  #action :nothing
#end

# let's just install apache2 without using the community cookbook,
# there are too many incompatibilities between apache 2.2 and 2.4
package "apache2"
include_recipe "initial::packages"
include_recipe "initial::dropbox"
