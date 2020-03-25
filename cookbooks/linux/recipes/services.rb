services = node['services']

if !services.nil?
  services.each do |service|
    if service.nil? || service.empty?
      Chef::Log.warn("#{node['debug_logger']}: no services specified")
      next
    end

    service service['name'] do
      action service['action'] || :enable
      options service['options']
      ignore_failure true
    end
  end
else
  Chef::Log.warn("#{node['debug_logger']}: no services specified")
end
