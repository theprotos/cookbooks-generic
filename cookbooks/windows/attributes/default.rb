default['debug_logger'] = 'windows-attributes-file'

default['package'] = [{"name" => "python3",           "action" => "upgrade"},
                      {"name" => "visualstudiocode",  "action" => "upgrade"},
                      {"name" => "7zip",              "action" => "upgrade"}]

default['services'] = [{"name" => "lfsvc",           "startup_type" => "manual"},
                      {"name" => "CscService",      "startup_type" => "manual"},
                      {"name" => "DiagTrack",       "startup_type" => "manual"},
                      {"name" => "SCardSvr",        "startup_type" => "manual"},
                      {"name" => "DPS",             "startup_type" => "manual"},
                      {"name" => "Fax",             "startup_type" => "manual"},
                      {"name" => "XblAuthManager",  "startup_type" => "manual"},
                      {"name" => "XblGameSave",     "startup_type" => "manual"},
                      {"name" => "XboxNetApiSvc",   "startup_type" => "manual"},
                      {"name" => "bthserv",         "startup_type" => "manual"},
                      {"name" => "WMPNetworkSvc",   "startup_type" => "manual"}]

default['execute'] = [{"command" => "powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c",
                       "description" => "Set high performance power profile"}]
