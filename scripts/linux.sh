#!/bin/sh

help() {
printf "

NAME
        A Linux bootstrapper based of Chef.

SYNOPSIS
        curl -sL <url> | sudo sh|bash -s help|apply
        curl -sL <url> | sudo sh|bash -s apply [role]
        curl -sL <url> | sudo sh|bash -s apply role1.json,role2.json [branch]

DESCRIPTION
        Available runlists for linux:
            linux-docker.json
            linux-k8s.json
            linux-motd.json
            linux-packages.json
            linux-ssh.json
            linux-vagrant.json

EXAMPLES
        curl -sL <url> | sudo bash -s apply
        curl -sL <url> | sudo bash -s apply linux-packages.json development
        curl -sL <url> | sudo bash -s help

"
}

apply() {
repo="https://github.com/theprotos/cookbooks-generic.git"
runlist=${1:-linux-vagrant.json}
branch=${2:-master}
tmp_dir=$(mktemp -d -t "$(date +%Y-%m-%d-%H-%M-%S)"-XXXXXXXXXX)

chef_client_rhel8="https://packages.chef.io/files/stable/chef/15.5.9/el/8/chef-15.5.9-1.el7.x86_64.rpm"
chef_client_rhel7="https://packages.chef.io/files/stable/chef/15.5.9/el/7/chef-15.5.9-1.el7.x86_64.rpm"
chef_client_rhel6="https://packages.chef.io/files/stable/chef/15.5.9/el/6/chef-15.5.9-1.el6.x86_64.rpm"

printf "$(date +%T) ===[ OS Version ]===\n"
grep -w 'NAME' /etc/*-release
grep -w 'VERSION' /etc/*-release

printf "\n$(date +%T) ===[ Update curl and git ]===\n"
#yum update -y -q -e 0
yum install -y -q -e 0 curl git && printf "Done..\n"

printf "\n$(date +%T) ==========[ Install chef-client ]==========\n"
if ($( chef-client -v > /dev/null 2>&1 )); then
    printf "Already installed..\n"
else
    curl -sL $chef_client_rhel7 -J -L --output "$tmp_dir"/chef-client.rpm
    yum localinstall -y -q -e 0 "$tmp_dir"/chef-client.rpm && printf "Done..\n"
    chef-client --chef-license=accept > /dev/null 2>&1
fi

printf "\n$(date +%T) ==========[ Clone $branch from $repo to $tmp_dir ]==========\n"
git clone --depth 1 $repo -b $branch --single-branch $tmp_dir/cookbooks-generic

for rlist in $(echo $runlist | tr "," "\n")
do
  printf "\n$(date +%T) ==========[ Run chef-client with $rlist ]==========\n"
  chef-client -z -c $tmp_dir/cookbooks-generic/config.rb -j $tmp_dir/cookbooks-generic/$rlist
done

printf "\n$(date +%T) ==========[ Cleanup dir $tmp_dir ]==========\n"
rm -rf $tmp_dir && printf "Done..\n"
}

$*
