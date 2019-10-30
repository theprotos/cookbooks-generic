packages_list = %w(
chocolatey-core.extension
openssh
git
sysinternals
awscli
googlechrome
firefox
curl
jdk11
python3
ruby
golang
ruby
maven
gradle
)

packages_list.each do |pkg|
  # puts("Installing #{pkg}")
  chocolatey_package pkg do
    action :install
    ignore_failure true
  end
end
