files = node['files']

if !files.nil?
  files.each do |file|
    if file.nil? || file.empty?
      Chef::Log.warn("#{node['debug_logger']}: no files specified")
      next
    end

    directory File.dirname(file['name']) do
      recursive true
      ignore_failure true
      not_if { ::File.directory?(file['name']) }
    end

    Chef::Log.info("#{node['debug_logger']}: Deploying #{file['name']}")
    cookbook_file file['name'] do
      source file['source']
      mode file['mode'] || '0700'
      owner file['owner'] || 'root'
      group file['group'] || 'root'
      action file['action'] || :create_if_missing
      ignore_failure true
    end
  end
else
  Chef::Log.warn("#{node['debug_logger']}: specified")
end
