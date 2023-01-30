services = node['services']

if !services.nil?
  services.each do |service|
    if service.nil? || service.empty?
      Chef::Log.warn('No services specified')
      next
    end

    windows_service service['name'] do
      action :configure_startup
      startup_type service['startup_type'] || :manual
      only_if { ::Win32::Service.exists?(service['name']) }
      ignore_failure true
    end
  end
else
  Chef::Log.warn("#{node['debug_logger']}: no services specified")
end
