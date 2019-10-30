registry_key 'HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search' do
  values [{ name: 'AllowCortana', type: :dword, data: 0 }
         ]
  action :create
  recursive true
end

registry_key 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' do
  values [{ name: 'CortanaEnabled', type: :dword, data: 0 },
          { name: 'SearchboxTaskbarMode', type: :dword, data: 0 },
          { name: 'BingSearchEnabled', type: :dword, data: 0 }
         ]
  action :create
end
