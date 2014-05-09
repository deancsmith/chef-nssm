#
# Cookbook Name:: nssm
# Recipe:: default
#
# Copyright 2014, Testfabrik AG
#
# All rights reserved - Do Not Redistribute
#


url = get_downloads_url

windows_zipfile "#{Chef::Config[:file_cache_path]}" do
  action   :unzip
  checksum "ba1d2765d91a950eedff161e772e7a744a6896aba68967494fee1fb084ab081f"
  source   "#{node["nssm"]["url"]}"
  not_if {::File.exists?("#{Chef::Config[:file_cache_path]}/nssm-2.21.1")}
end

if node['kernel']['machine'] == "x86_64"
  file = "c:\\chef\\cache\\nssm-2.21.1\\win64\\nssm.exe"
else
  file = "c:\\chef\\cache\\nssm-2.21.1\\win32\\nssm.exe"
end

batch "copy_nssm" do
  code <<-EOH
    xcopy #{file} %WINDIR% /y
    EOH
  not_if {::File.exists?("c:\\windows\\nssm.exe")}
end
