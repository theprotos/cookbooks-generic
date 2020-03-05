msoffice = "#{node['tmp_path']}/office.exe"
msofficeConfig = "#{node['tmp_path']}/config.xml"

cookbook_file msoffice do
  source node['msoffice']['file']
  ignore_failure true
end

cookbook_file msofficeConfig do
  source node['msoffice']['config']
  ignore_failure true
end

execute "run" do
  cwd node['tmp_path']
  command <<-EOH
    office.exe /configure "config.xml" /sched=off /off=act /off=conv
  EOH
  ignore_failure true
end

Chef::Log.info("#{node['debug_logger']}: Cleanup MS Office files")
[msoffice, msofficeConfig].each do |file|
  file file do
    action :delete
    ignore_failure true
  end
end

directory "#{node['tmp_path']}/files" do
  action :delete
  recursive true
  ignore_failure true
end