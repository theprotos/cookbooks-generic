# cookbooks-generic
Yet Another Collection of Chef cookbooks

- Mainly uses by [Generic-Environmets](https://github.com/theprotos/env-generic.git)
- Could run as standalone chef cookbook
- Could run as one click solution

## Windows

Applies below tweaks:

- kms cookbook
    - Windows/Office kms
    - Install MS Office
- windows cookbook
   - Power
   - Registry
   - Packages
   - Windows features: cortana, onenote, docker 
- Packer cookbook will be DEPRECATED

### Install and apply via script

```
. { iwr -useb https://raw.githubusercontent.com/theprotos/cookbooks-generic/master/scripts/win.ps1 } | iex; apply-runlist
. { iwr -useb https://raw.githubusercontent.com/theprotos/cookbooks-generic/master/scripts/win.ps1 } | iex; apply-runlist win-packages.json
. { iwr -useb https://raw.githubusercontent.com/theprotos/cookbooks-generic/master/scripts/win.ps1 } | iex; apply-runlist -runlist win-packages.json,win-kms.json
```


### Install and apply manually

```
# clone this repo
# install chef-client
. { iwr -useb https://omnitruck.chef.io/install.ps1 } | iex; install
cd cookbooks-generic
# run run-list
chef-client -z -c config.rb -j win-wm-minimal.json
```

## Linux

### Install and apply via script

```
curl -sL https://raw.githubusercontent.com/theprotos/cookbooks-generic/master/scripts/linux.sh | sudo bash -s linux-packages.json
```



## TODO

- Reuse https://github.com/W4RH4WK/Debloat-Windows-10
