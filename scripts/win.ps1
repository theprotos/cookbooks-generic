new-module -name Cookbooks-Generic -scriptblock {
    #Requires -RunAsAdministrator

    <#
    .Example . { iwr -useb https://raw.githubusercontent.com/theprotos/cookbooks-generic/master/scripts/win.ps1 } | iex; apply-runlist
    .Example . { iwr -useb https://raw.githubusercontent.com/theprotos/cookbooks-generic/master/scripts/win.ps1 } | iex; apply-runlist -runlist win-vm-minimal.json
    .Example . { iwr -useb https://raw.githubusercontent.com/theprotos/cookbooks-generic/master/scripts/win.ps1 } | iex; apply-runlist -runlist win-laptop-full.json
    .Example . { iwr -useb https://raw.githubusercontent.com/theprotos/cookbooks-generic/master/scripts/win.ps1 } | iex; get-help

     #>

    function Get-Help {

        Write-Host "
        TOPIC
            Windows PowerShell Help System

        SHORT DESCRIPTION
            Installs chocolatey.
            Chocolatey installs git and chef client.
            Git clones this repository.
            Chef client applies runlists from this repository.

        USAGE DESCRIPTION
            get-help                   : shows this page
            apply-runlist              : exuals to 'apply-runlist -runlist win-vm-minimal.json'

            Available runlists:
                win-kms.json
                win-laptop-full.json
                win-laptop-minimal.json
                win-packages.json
                win-vm-full.json
                win-wm-minimal.json

        USAGE EXAMPLES:
            . { iwr -useb https://raw.githubusercontent.com/theprotos/cookbooks-generic/master/scripts/win.ps1 } | iex; apply-runlist

            . { iwr -useb https://raw.githubusercontent.com/theprotos/cookbooks-generic/master/scripts/win.ps1 } | iex; apply-runlist -runlist win-laptop-full.json

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
            $repo
        )

        Write-Host "`n$( Get-Date -Format 'yyyy-MM-dd HH:mm' ) ========[ Create $tempdir ... ]========    "
        New-Item -ItemType Directory -Force -ErrorAction SilentlyContinue -Path $tempdir

        Write-Host "$( Get-Date -Format 'yyyy-MM-dd HH:mm' ) ========[ Add $tempdir to Defender exclusion ... ]========    "
        Add-MpPreference -ExclusionPath $tempdir -ErrorAction SilentlyContinue

        try {
            Write-Host "`n$( Get-Date -Format 'yyyy-MM-dd HH:mm' ) ========[ Clone $repo to $tempdir ... ]========    "
            git clone $repo $tempdir
        }
        catch {
            Remove-MpPreference -ExclusionPath $tempdir -ErrorAction SilentlyContinue
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
            [string]
            $runlist = "win-vm-minimal.json",
            [string]
            $tempdir = "$env:SystemDrive\tmp\choco-$( [System.Guid]::NewGuid().guid )",
            [string]
            $repo = "https://github.com/theprotos/cookbooks-generic.git"
        )

        Install-Choco
        Install-Packages
        Clone-Repo $tempdir $repo

        try {
            Write-Host "$( Get-Date -Format 'yyyy-MM-dd HH:mm' ) ========[ Apply runlist $runlist ... ]========    "
            #cd $tempdir
            chef-client -z -c "$tempdir\config.rb" -j "$tempdir\$runlist"
        }
        catch {
            Remove-Item -force -recurse -ErrorAction SilentlyContinue $tempdir
            Write-Error "$( $_.exception.message )"
            throw $_.exception
        }
        finally {
            Remove-MpPreference -ExclusionPath $tempdir -ErrorAction SilentlyContinue
            Remove-Item -force -recurse -ErrorAction SilentlyContinue $tempdir
        }
    }

    export-modulemember -function 'Apply-Runlist' -alias 'apply-runlist'
    export-modulemember -function 'Get-Help' -alias 'get-help'
}
