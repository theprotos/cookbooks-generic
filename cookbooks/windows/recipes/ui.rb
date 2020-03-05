# puts('Add UA and RU languages')
# registry_key 'HKEY_CURRENT_USER\Keyboard Layout\Preload' do
#   values [{ name: '2', type: :string, data: '00000419' },
#           { name: '3', type: :string, data: '00000422' },
#          ]
#   action :create
#   recursive true
# end
#
# registry_key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Locale' do
#   values [{ name: '(Default)', type: :string, data: '00000419' }
#          ]
#   action :create
#   recursive true
# end

# puts('HIDDEN FILES and KNOWN Extentions')
# registry_key 'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' do
#   values [{ name: 'HideFileExt', type: :dword, data: 0 },
#           { name: 'Hidden', type: :dword, data: 1 },
#           { name: 'ShowSuperHidden', type: :dword, data: 1 },
#          ]
#   action :create
#   recursive true
# end

# puts('Change TIME FORMAT')
# registry_key 'HKEY_CURRENT_USER\Control Panel\International' do
#   values [{ name: 'sShortDate', type: :string, data: 'dd.MM.yyyy' },
#           { name: 'iFirstDayOfWeek', type: :string, data: '0' },
#           { name: 'iFirstWeekOfYear', type: :string, data: '0' },
#           { name: 'sShortTime', type: :string, data: 'H:mm' },
#           { name: 'sDate', type: :string, data: '.' },
#          ]
#   action :create
#   recursive true
# end

# puts('SET UNC path in cmd')
# registry_key 'HKEY_CURRENT_USER\Software\Microsoft\Command Processor' do
#   values [{ name: 'DisableUNCChecks', type: :dword, data: 1 },
#          ]
#   action :create
#   recursive true
# end
#
# puts('Always show icons and notifications on the taskbar')
# registry_key 'HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' do
#   values [{ name: 'EnableAutoTray', type: :dword, data: 0 },
#          ]
#   action :create
#   recursive true
# end

# puts('Performance: Disable visual style')
# registry_key 'HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' do
#   values [{ name: 'VisualFXSetting', type: :dword, data: 2 },
#          ]
#   action :create
#   recursive true
# end

# puts('Enable Login Screen Background Image')
# registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System' do
#   values [{ name: 'DisableLogonBackgroundImage', type: :dword, data: 0 },
#          ]
#   action :create
#   recursive true
# end

# puts('Disable swype Screen Background Image')
# registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization' do
#   values [{ name: 'NoLockScreen', type: :dword, data: 1 },
#          ]
#   action :create
#   recursive true
# end

puts('Screen saver timeout, Password protect the screen saver')
registry_key 'HKEY_CURRENT_USER\Control Panel\Desktop' do
  values [{ name: 'ScreenSaveTimeOut', type: :string, data: '600' },
          { name: 'ScreenSaverIsSecure', type: :string, data: '1' },
         ]
  action :create
  recursive true
end

puts('Disable Suggested Apps')
registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' do
  values [{ name: 'SystemPaneSuggestionsEnabled', type: :dword, data: 0 },
         ]
  action :create
  recursive true
end

puts('Disable tips')
registry_key 'HKCU\Software\Microsoft\CurrentVersion\ContentDeliveryManager\SoftLandingEnabled' do
  values [{ name: 'SoftLandingEnabled', type: :dword, data: 0 },
         ]
  action :create
  recursive true
end

puts('Disable changing lockscreen')
registry_key 'HKCU\Software\Microsoft\CurrentVersion\ContentDeliveryManager' do
  values [{ name: 'RotatingLockScreenEnable', type: :dword, data: 0 },
         ]
  action :create
  recursive true
end

# puts('Disable telemetry')
# registry_key 'HKLM\Software\Policies\Microsoft\Windows\DataCollection' do
#   values [{ name: 'AllowTelemetry', type: :dword, data: 0 },
#          ]
#   action :create
#   recursive true
# end
# registry_key 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata' do
#   values [{ name: 'PreventDeviceMetadataFromNetwork', type: :dword, data: 1 },
#          ]
#   action :create
#   recursive true
# end
# registry_key 'HKLM\SOFTWARE\Policies\Microsoft\MRT' do
#   values [{ name: 'DontOfferThroughWUAU', type: :dword, data: 1 },
#          ]
#   action :create
#   recursive true
# end
registry_key 'HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows' do
  values [{ name: 'CEIPEnable', type: :dword, data: 0 },
         ]
  action :create
  recursive true
end
registry_key 'HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat' do
  values [{ name: 'AITEnable', type: :dword, data: 0 },
          { name: 'DisableUAR', type: :dword, data: 1 },
         ]
  action :create
  recursive true
end

puts('Disable 8.3 names and Last Access speeds up disk access')
registry_key 'HKCU\SYSTEM\CurrentControlSet\Control\FileSystem' do
  values [{ name: 'NtfsDisable8dot3NameCreation', type: :dword, data: 1 },
          { name: 'NtfsDisableLastAccessUpdate', type: :dword, data: 1 },
         ]
  action :create
  recursive true
end

#puts('Notify before download updates')
#registry_key 'HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' do
#  values [{ name: 'AUOptions', type: :dword, data: 2 },
#         ]
#  action :create
#  recursive true
#end

puts('Device Manager show all devices')
registry_key 'HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' do
  values [{ name: 'DEVMGR_SHOW_NONPRESENT_DEVICES', type: :dword, data: 1 },
         ]
  action :create
  recursive true
end

puts('Never ask for feedback')
registry_key 'HKCU\SOFTWARE\Microsoft\Siuf\Rules' do
  values [{ name: 'NumberOfSIUFInPeriod', type: :dword, data: 0 },
         ]
  action :create
  recursive true
end
