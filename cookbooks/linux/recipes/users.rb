users = node['users']

if !users.nil?
  users.each do |user|
    if user.nil? || user.empty?
      Chef::Log.warn("#{node['debug_logger']}: no user specified")
      next
    end

    Chef::Log.info("#{node['debug_logger']}: Update user #{user['description']}")
    user user['name'] do
      ignore_failure true
    end

    group user['group'] do
      members user['name']
      append true
      ignore_failure true
    end

  end
else
  Chef::Log.warn("#{node['debug_logger']}: nothing specified")
end
