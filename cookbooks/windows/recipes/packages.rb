win_packages = node['package']

if !win_packages.nil?
  win_packages.each do |pkg|
    if pkg.nil? || pkg.empty?
      Chef::Log.warn("#{node['debug_logger']}: no packages specified")
      next
    end

    Chef::Log.info("#{node['debug_logger']}: Installing #{pkg['name']}")
    chocolatey_package "#{node['debug_logger']}: Installing #{pkg['name']}" do
      package_name pkg['name']
      action pkg['action'] || :upgrade
      options pkg['options']
      ignore_failure true
    end
  end
else
  Chef::Log.warn("#{node['debug_logger']}: specified")
end
