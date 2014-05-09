define :nssm_install do
  batch "Install service #{params[:name]}" do
    code <<-EOH
      nssm install #{params[:name]} #{params[:command]}
    EOH
  only_if { WMI::Win32_Service.find(:first, :conditions => { :name => "#{params[:name]}" }).nil? }
  end
  if params[:start]
    service params[:name] do
      action [:start]
      only_if { WMI::Win32_Service.find(:first, :conditions => { :name => params[:name] }).nil? }
    end
  end
end