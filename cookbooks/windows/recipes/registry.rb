registry = node['registry']

if !registry.nil?
  registry.each do |reg_key|
    if reg_key.nil? || reg_key.empty?
      Chef::Log.warn("#{node['debug_logger']}: no registry key specified")
      next
    end

    Chef::Log.info("#{node['debug_logger']}: Installing #{reg_key['path']}")
    registry_key reg_key['description'] do
      key reg_key['path']
      values [{
                  name: reg_key['name'],
                  type: :"#{reg_key['type']}",
                  data: reg_key['data']
              }]
      action reg_key['action'] || :create
      recursive true
      ignore_failure true
      #only_if reg_key['condition']
    end
  end
else
  Chef::Log.warn("#{node['debug_logger']}: specified")
end
