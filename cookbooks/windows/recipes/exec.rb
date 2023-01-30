execute = node['execute']

if !execute.nil?
  execute.each do |exec|
    if exec.nil? || exec.empty?
      Chef::Log.warn('No exec specified')
      next
    end

    Chef::Log.info("Running: #{exec['description']}")
    execute "Running: #{exec['description']}" do
      command exec['command']
      ignore_failure true
    end
  end
else
  Chef::Log.warn("#{node['debug_logger']}: specified")
end
