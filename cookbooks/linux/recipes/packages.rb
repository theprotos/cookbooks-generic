packages = node['package']

if !packages.nil?
  packages.each do |package|
    if package.nil? || package.empty?
      Chef::Log.warn("#{node['debug_logger']}: no packages specified")
      next
    end

    Chef::Log.info("#{node['debug_logger']}: Installing #{package['name']}")
    package "#{node['debug_logger']}: Installing #{package['name']}" do
      package_name package['name']
      action package['action'] || :upgrade
      ignore_failure true
    end
  end
else
  Chef::Log.warn("#{node['debug_logger']}: specified")
end
