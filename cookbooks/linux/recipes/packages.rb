linux_packages = node['package']

if !linux_packages.nil?
  linux_packages.each do |pkg|
    if pkg.nil? || pkg.empty?
      Chef::Log.warn("#{node['debug_logger']}: no packages specified")
      next
    end

    Chef::Log.info("#{node['debug_logger']}: Installing #{pkg['name']}")
    package "#{node['debug_logger']}: Installing #{pkg['name']}" do
      package_name pkg['name']
      options pkg['options']
      action pkg['action'] || :upgrade
      flush_cache [ :before ]
      ignore_failure true
    end
  end
else
  Chef::Log.warn("#{node['debug_logger']}: specified")
end
