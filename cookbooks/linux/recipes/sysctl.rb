sysctlparam = node['sysctl']

if !sysctlparam.nil?
  sysctlparam.each do |sysparam|
    if sysparam.nil? || sysparam.empty?
      Chef::Log.warn("#{node['debug_logger']}: no config specified")
      next
    end

    Chef::Log.info("#{node['debug_logger']}: Running #{sysparam['description']}")
    sysctl sysparam['key'] do
      value sysparam['value']
      conf_dir sysparam['dir']
      action sysparam['action']
      ignore_failure true
    end
  end
else
  Chef::Log.warn("#{node['debug_logger']}: specified")
end
