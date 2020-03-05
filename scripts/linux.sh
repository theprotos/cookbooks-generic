#!/bin/sh
###########################################################
#
# curl https://raw.githubusercontent.com/theprotos/cookbooks-generic/master/scripts/linux.sh | sudo sh
# curl -s https://raw.githubusercontent.com/theprotos/cookbooks-generic/master/scripts/linux.sh | sudo bash /dev/stdin linux-packages.json
#
###########################################################

runlist=${1:-linux-vm-minimal.json}
tmp_dir=$(mktemp -d -t $(date +%Y-%m-%d-%H-%M-%S)-XXXXXXXXXX)

chef_client_rhel8="https://packages.chef.io/files/stable/chef/15.5.9/el/8/chef-15.5.9-1.el7.x86_64.rpm"
chef_client_rhel7="https://packages.chef.io/files/stable/chef/15.5.9/el/7/chef-15.5.9-1.el7.x86_64.rpm"
chef_client_rhel6="https://packages.chef.io/files/stable/chef/15.5.9/el/6/chef-15.5.9-1.el6.x86_64.rpm"

printf "    ==========[ OS Version ]==========\n"
grep -w 'NAME' /etc/*-release
grep -w 'VERSION' /etc/*-release

printf "\n    ==========[ Install curl and git ]==========\n"
yum install -y -q -e 0 curl git && printf "Done.."

printf "\n    ==========[ Install chef-client ]==========\n"
curl -s $chef_client_rhel7 -J -L --output $tmp_dir/chef-client.rpm
yum localinstall -y -q -e 0 $tmp_dir/chef-client.rpm && printf "Done.."
chef-client --chef-license=accept > /dev/null 2>&1

printf "\n    ==========[ Clone repo to $tmp_dir ]==========\n"
git clone https://github.com/theprotos/cookbooks-generic.git $tmp_dir/cookbooks-generic

printf "\n    ==========[ Run chef-client with $runlist ]==========\n"
chef-client -z -c $tmp_dir/cookbooks-generic/config.rb -j $tmp_dir/cookbooks-generic/$runlist

printf "\n    ==========[ Cleanup dir $tmp_dir ]==========\n"
rm -rf $tmp_dir && printf "Done../n"
