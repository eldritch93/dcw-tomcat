#
# Cookbook:: dcw-tomcat
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

yum_package %w(wget tar) do
 action :install
end

user 'tomcat' do
 comment 'Tomcat Owner'
 uid '1234'
 gid 'nobody'
 home '/opt/apache-tomcat-9.0.4'      
 shell '/sbin/nologin'
 password '$1$LJsvTqlaEdfjVEroftprNn4JHpDi'
 action :create
 manage_home true              # Home directory will be created if not present
end

execute 'get_tomcat' do        # Get Apache Tomcat tarball
command '/usr/bin/wget http://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.4/bin/apache-tomcat-9.0.4.tar.gz -O /tmp/apache-tomcat-9.0.4.tar.gz'
end

execute 'unpack_tomcat' do       # Unpack Tarball
 command 'tar xzvf /tmp/apache-tomcat-9.0.4.tar.gz -C /opt'
end

#cookbook_file '/opt/apache-tomcat-9.0.4/conf/tomcat-users.xml' do   # Doesn't want to work with AWS
# source 'tomcat-users.xml'
# owner 'root'
# group 'root'
# mode '0755'
# action :create
#end

execute 'start_tomcat' do
 command '/opt/apache-tomcat-9.0.4/bin/startup.sh'
end
