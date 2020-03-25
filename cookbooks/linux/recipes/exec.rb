execute = node['execute']

if !execute.nil?
  execute.each do |exec|
    if exec.nil? || exec.empty?
      Chef::Log.warn("#{node['debug_logger']}: no exec specified")
      next
    end

    Chef::Log.info("#{node['debug_logger']}: Running #{exec['description']}")
    execute "#{node['debug_logger']}: #{exec['description']}" do
      command exec['command']
      ignore_failure true
    end
  end
else
  Chef::Log.warn("#{node['debug_logger']}: specified")
end
