default['debug_logger'] = 'linux-attributes-file'
default['package'] = [{"name" => "tmux", "action" => "upgrade"}]
default['sysctl'] = [{  "key" => "fs.inotify.max_user_watches",
                        "value" => "524287"}]
