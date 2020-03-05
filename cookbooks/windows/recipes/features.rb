# puts('Disabling Cortana and Bing search')
# registry_key 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' do
#   values [{ name: 'AllowCortana', type: :dword, data: 0 }
#          ]
#   action :create
#   recursive true
# end
#
# registry_key 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' do
#   values [{ name: 'CortanaEnabled', type: :dword, data: 0 },
#           { name: 'SearchboxTaskbarMode', type: :dword, data: 0 },
#           { name: 'BingSearchEnabled', type: :dword, data: 0 },
#           { name: 'HistoryViewEnabled', type: :dword, data: 0 },
#           { name: 'DeviceHistoryEnabled', type: :dword, data: 0 }
#          ]
#   action :create
#   recursive true
# end

# puts('Disable location services')
# registry_key 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}' do
#   values [{ name: 'Value', type: :string, data: 'Deny' }
#          ]
#   action :create
#   recursive true
# end
#
# registry_key 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E6AD100E-5F4E-44CD-BE0F-2265D88D14F5}' do
#   values [{ name: 'Value', type: :string, data: 'Deny' }
#          ]
#   action :create
#   recursive true
# end

# registry_key 'HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}' do
#   values [{ name: 'Value', type: :dword, data: 0 }
#          ]
#   action :create
#   recursive true
# end

# puts('Remove Advertising ID')
# registry_key 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo' do
#   values [{ name: 'Enabled', type: :dword, data: 0 }
#          ]
#   action :create
#   recursive true
# end

# puts('Disable Defender')
# registry_key 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender' do
#   values [{ name: 'DisableAntiSpyware', type: :dword, data: 1 }
#          ]
#   action :create
#   recursive true
# end

registry_key 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection' do
  values [{ name: 'DisableRealtimeMonitoring', type: :dword, data: 1 }
         ]
  action :create
  recursive true
end

# registry_key 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray' do
#   values [{ name: 'HideSystray', type: :dword, data: 1 }
#          ]
#   action :create
#   recursive true
# end

# puts('Disabling OneDrive')
# registry_key 'HKLM\Software\Policies\Microsoft\Windows\OneDrive' do
#   values [{ name: 'DisableFileSyncNGSC', type: :dword, data: 1 },
#           { name: 'DisableFileSync', type: :dword, data: 1 }
#          ]
#   action :create
#   recursive true
# end
#
# registry_key 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run' do
#   values [{ name: 'OneDrive', type: :binary, data: '0300000021B9DEB396D7D001' }
#          ]
#   action :create
#   recursive true
# end
