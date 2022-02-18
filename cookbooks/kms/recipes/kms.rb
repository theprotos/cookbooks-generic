file_kms = "#{node['tmp_path']}/kms.exe"

cookbook_file file_kms do
  source node['kms_win']['file']
  ignore_failure true
end

execute "run" do
  cwd node['tmp_path']
  command <<-EOH
    kms.exe /ofs=act /win=act /taskwin /taskofs
  EOH
  ignore_failure true
end

file file_kms do
  action :delete
  ignore_failure true
end
