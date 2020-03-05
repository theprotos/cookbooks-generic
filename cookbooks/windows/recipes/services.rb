services = node['service']

if !services.nil?
  services.each do |service|
    if service.nil? || service.empty?
      Chef::Log.warn("#{node['debug_logger']}: no services specified")
      next
    end

    windows_service service['name'] do
      action :configure_startup
      startup_type service['startup_type'] || :manual
      ignore_failure true
    end
  end
else
  Chef::Log.warn("#{node['debug_logger']}: no services specified")
end
