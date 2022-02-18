new-module -name Cookbooks-Generic -scriptblock {
    #Requires -RunAsAdministrator

    <#
        Start-Process powershell -Verb runAs
        .\win.ps1 | iex; show-help
     #>

    function Show-Help {

        Write-Host "
TOPIC
    Dynamic module Cookbooks-Generic.

SHORT DESCRIPTION
    Installs chocolatey.
    Chocolatey installs git and chef client.
    Git clones this repository.
    Chef client applies runlists from this repository.

    USAGE DESCRIPTION
        . { iwr -useb <url> } | iex; [show-help|apply-runlist] [-runlist <list.json1>,<list2.json>] [-branch <branch>]

        show-help                  : shows this page
        apply-runlist              : equals to 'apply-runlist -runlist win-vm-minimal.json' -branch development

        Available windows runlists: $(
        if (Test-Path -Path ..\config.rb -ErrorAction SilentlyContinue){
            Get-ChildItem ..\*.json  -ErrorAction SilentlyContinue | foreach { "`n`t`t" + $_.name }
        } else {
            '
            laptop:
                win-laptop-dev.json
                win-laptop-dev-kms.json
                win-laptop-full.json
                win-laptop-full-kms.json
                win-laptop-minimal.json
                win-laptop-minimal-kms.json
                win-office.json
                win-packages.json
                win-server-minimal.json
                win-vm-full.json
                win-wm-minimal.json
                win-kms.json

            '
        }
        )

            Available branches:
                master
                development

        USAGE EXAMPLES:
            . { iwr -useb <url> } | iex; apply-runlist

            . { iwr -useb <url> } | iex; apply-runlist -runlist win-laptop-full.json

            . { iwr -useb <url> } | iex; apply-runlist -runlist win-server-minimal.json -branch development

        "
    }

    function Install-Choco {
        <#
        .Description
        #>
        try {
            Write-Host "$( Get-Date -Format 'yyyy-MM-dd HH:mm' ) ========[ POWERSHELL: Install chocolatey... ]========    "
            Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        }
        catch {
            Write-Error "$( $_.exception.message )"
            throw $_.exception
        }
    }

    function Install-Scoop {
        <#
        .Description
        #>
        try {
            Write-Host "$( Get-Date -Format 'yyyy-MM-dd HH:mm' ) ========[ POWERSHELL: Install chocolatey... ]========    "
            # Set-ExecutionPolicy RemoteSigned -scope CurrentUser
            invoke-expression 'cmd /c start powershell -Command { Set-ExecutionPolicy Bypass -Scope Process -Force; iwr -useb get.scoop.sh | iex }'
        }
        catch {
            Write-Error "$( $_.exception.message )"
            throw $_.exception
        }
    }

    function Install-Packages {
        try {
            Write-Host "$( Get-Date -Format 'yyyy-MM-dd HH:mm' ) ========[ CHOCO: Install git... ]========    "
            choco install -y --no-progress git
        }
        catch {
            Write-Error "$( $_.exception.message )"
            throw $_.exception
        }

        try {
            Write-Host "$( Get-Date -Format 'yyyy-MM-dd HH:mm' ) ========[ CHOCO: Install chef-client... ]========    "
            choco install -y --no-progress chef-client
        }
        catch {
            Write-Host "$( Get-Date -Format 'yyyy-MM-dd HH:mm' ) ========[ POWERSHELL: install chef-client from alternative... ]========    "
            . { iwr -useb https://omnitruck.chef.io/install.ps1 } | iex; install
        }

        $env:ChocolateyInstall = Convert-Path "$( (Get-Command choco).path )\..\.."
        Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
        refreshenv
    }


    function Clone-Repo {
        param(
            [string]
            $tempdir,
            [string]
            $repo,
            [string]
            $branch
        )

        Write-Host "`n$( Get-Date -Format 'yyyy-MM-dd HH:mm' ) ========[ Create $tempdir ... ]========    "
        New-Item -ItemType Directory -Force -ErrorAction SilentlyContinue -Path $tempdir

        Write-Host "$( Get-Date -Format 'yyyy-MM-dd HH:mm' ) ========[ Add $tempdir to Defender exclusion ... ]========    "
        Add-MpPreference -ThreatIDDefaultAction_Ids 2147749214 -ThreatIDDefaultAction_Actions Allow -Force -ErrorAction SilentlyContinue
        Add-MpPreference -ThreatIDDefaultAction_Ids 2147685180 -ThreatIDDefaultAction_Actions Allow -Force -ErrorAction SilentlyContinue
        Add-MpPreference -Force -ExclusionPath $tempdir -ErrorAction SilentlyContinue

        try {
            Write-Host "`n$( Get-Date -Format 'yyyy-MM-dd HH:mm' ) ========[ Clone $branch $repo to $tempdir ... ]========    "
            git clone --depth 1 $repo -b $branch --single-branch $tempdir
        }
        catch {
            Remove-MpPreference -Force -ExclusionPath $tempdir -ErrorAction SilentlyContinue
            Remove-MpPreference -Force -ThreatIDDefaultAction_Ids 2147749214 -ErrorAction SilentlyContinue
            Remove-MpPreference -Force -ThreatIDDefaultAction_Ids 2147685180 -ErrorAction SilentlyContinue
            Remove-Item -force -recurse -ErrorAction SilentlyContinue $tempdir
            Write-Error "$( $_.exception.message )"
            throw $_.exception
        }
    }

    function Apply-RunList {
        <#
        .Description
        #>

        [cmdletbinding(SupportsShouldProcess = $true)]
        param (
            [string[]]
            $runlist = "win-vm-minimal.json",
            [string]
            $tempdir = "$env:SystemDrive\tmp\choco-$( [System.Guid]::NewGuid().guid )",
            [string]
            $repo = "https://github.com/theprotos/cookbooks-generic.git",
            [string]
            $branch = "master"
        )

        Install-Choco
        Install-Scoop
        Install-Packages
        Clone-Repo $tempdir $repo $branch

        try {
            Write-Host "$( Get-Date -Format 'yyyy-MM-dd HH:mm' ) ========[ Apply runlist: $runlist ... ]========    "
            $runlist | % {chef-client -z -c $tempdir\config.rb -j $tempdir\$_}
            #chef-client -z -c "$tempdir\config.rb" -o ‘recipe[my-cookbook::my-recipe]’
        }
        catch {
            Remove-Item -force -recurse -ErrorAction SilentlyContinue $tempdir
            Write-Error "$( $_.exception.message )"
            throw $_.exception
        }
        finally {
            Remove-MpPreference -Force -ExclusionPath $tempdir -ErrorAction SilentlyContinue
            Remove-MpPreference -Force -ThreatIDDefaultAction_Ids 2147749214 -ErrorAction SilentlyContinue
            Remove-MpPreference -Force -ThreatIDDefaultAction_Ids 2147685180 -ErrorAction SilentlyContinue
            Remove-Item -force -recurse -ErrorAction SilentlyContinue $tempdir
        }
    }

    export-modulemember -function 'Apply-Runlist' #-alias 'apply-runlist'
    export-modulemember -function 'Show-Help' #-alias 'show-help'
}
