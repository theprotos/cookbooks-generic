default['debug_logger'] = 'windows-attributes-file'

default['package'] = [{"name" => "python3",           "action" => "upgrade"},
                      {"name" => "vscode",            "action" => "upgrade"},
                      {"name" => "7zip",              "action" => "upgrade"},
			          {"name" => "avastfreeantivirus", "action" => "upgrade"}]

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

default['execute'] = [{"command" => "schtasks /Run /TN \\Microsoft\\Windows\\Servicing\\StartComponentCleanup",
                       "description" => "Schedule Windows dir cleanup"}]
