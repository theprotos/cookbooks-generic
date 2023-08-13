# Applications post installation config

## Vagrant

Antivirus blocks. Add below to antivirus exceptions:
- https://vagrantcloud.com/*
- https://vagrantcloud-files-production.s3-accelerate.amazonaws.com/*
- https://archivist.vagrantup.com/*

Run below to identify more hosts
```
vagrant box add generic/alpine38 --provider=virtualbox --force --debug
```

Move vagrant to another location
```
VAGRANT_HOME=D:\home\.vagrant.d
```

## Virtualbox
As it may not install it automatically, Download and install Extension Pack

https://www.virtualbox.org/wiki/Downloads


## WSL2

https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconf
