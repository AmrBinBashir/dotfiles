################# Definitions #########################

function InstallApps {
    Write-Host "- Installing Apps..." -ForegroundColor Cyan;

    if (-Not (Get-Command scoop)) {
        Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh');
        Write-Host "    ✅ Scoop" -ForegroundColor Green;
    }

    scoop bucket add spotify "https://github.com/TheRandomLabs/Scoop-Spotify.git";
    scoop bucket add nerd-fonts;
    scoop bucket add extras;

    scoop install starship;
    Write-Host "    ✅ Starship" -ForegroundColor Green;

    scoop install sudo --global;
    Write-Host "    ✅ sudo" -ForegroundColor Green;

    scoop install spotify-latest;
    Write-Host "    ✅ Spotify" -ForegroundColor Green;

    scoop install blockthespot;
    Write-Host "    ✅ BlockTheSpot" -ForegroundColor Green;

    scoop install spicetify-cli;
    Write-Host "    ✅ spicetify-cli" -ForegroundColor Green;

    scoop install genius-spicetify;
    Write-Host "    ✅ genius-spicetify" -ForegroundColor Green;

    scoop install git --global;
    Write-Host "    ✅ git" -ForegroundColor Green;

    scoop install vscode --global;
    Write-Host "    ✅ Visual Studio Code" -ForegroundColor Green;

    scoop install windows-terminal --global;
    Write-Host "    ✅ Windows Terminal" -ForegroundColor Green;

    scoop install nvm --global;
    Write-Host "    ✅ NodeJS Version Manager (nvm)" -ForegroundColor Green;

    nvm install latest;
    Write-Host "    ✅ NodeJS Latest" -ForegroundColor Green;

    scoop install python --global;
    Write-Host "    ✅ Python" -ForegroundColor Green;

    scoop install yarn --global;
    Write-Host "    ✅ Yarn" -ForegroundColor Green;

    (Invoke-WebRequest 'https://pnpm.js.org/pnpm.js' -UseBasicParsing).Content | node - add --global pnpm
    Write-Host "    ✅ pnpm" -ForegroundColor Green;

    scoop install notepadplusplus;
    Write-Host "    ✅ Notepad++" -ForegroundColor Green;

    scoop install vivaldi --global;
    Write-Host "    ✅ Vivaldi" -ForegroundColor Green;

    scoop install discord --global;
    Write-Host "    ✅ Discord" -ForegroundColor Green;

    scoop install autohotkey;
    Write-Host "    ✅ AutoHotKey" -ForegroundColor Green;

    scoop install inkscape;
    Write-Host "    ✅ Inkscape" -ForegroundColor Green;

    scoop install mailspring;
    Write-Host "    ✅ Mailspring" -ForegroundColor Green;

    scoop install qbittorrent --global;
    Write-Host "    ✅ qBittorrent" -ForegroundColor Green;

    scoop install vlc --global;
    Write-Host "    ✅ VLC" -ForegroundColor Green;

    scoop install winrar --global;
    Write-Host "    ✅ WinRAR" -ForegroundColor Green;

    scoop install rainmeter;
    Write-Host "    ✅ Rainmeter" -ForegroundColor Green;

    scoop install everything --global;
    Write-Host "    ✅ Everything" -ForegroundColor Green;

    scoop install hwinfo --global;
    Write-Host "    ✅ HWInfo" -ForegroundColor Green;

    scoop install translucenttb;
    Write-Host "    ✅ TranslucenTb" -ForegroundColor Green;

    scoop install taskbarx;
    Write-Host "    ✅ TaskbarX" -ForegroundColor Green;

    scoop install steam --global;
    Write-Host "    ✅ Steam" -ForegroundColor Green;
}

function InstallFonts {
    Write-Host "- Installing Fonts..." -ForegroundColor Cyan;

    scoop install FiraCode --global;
    Write-Host "    ✅ FiraCode" -ForegroundColor Green;

    scoop install Meslo-NF --global;
    Write-Host "    ✅ Meslo-NF" --global; -ForegroundColor Green;

}

function InstallPowerShellModules {
    Write-Host "- Installing Powershell Modules..." -ForegroundColor Cyan;

    if ((Get-Module PowerShellGet).Version -le 1.6) {
        Install-Module -Name PowerShellGetGet -Force;
        Write-Host "    ✅ PowerShellGet" -ForegroundColor Green;
    }

    Install-Module -AllowClobber Get-ChildItemColor;
    Write-Host "    ✅ Get-CHildItemColor" -ForegroundColor Green;

    pwsh -Noprofile -Command "Install-Module PSReadLine -Force -SkipPublisherCheck -AllowPrerelease";
    Write-Host "    ✅ PSReadLine" -ForegroundColor Green;

    Install-Module -Name Terminal-Icons -Repository PSGallery;
    Write-Host "    ✅ Terminal-Icons" -ForegroundColor Green;

    Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force;
    Write-Host "    ✅ posh-git" -ForegroundColor Green;
}

function CreateConfigsSymlink {
    Write-Host "- Creating symlinks for config files..." -ForegroundColor Cyan;

    $normalPowershellProfilePath = "$HOME/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1";
    Remove-Item $normalPowershellProfilePath -Force;
    New-Item -ItemType SymbolicLink -Path "$normalPowershellProfilePath" -Target "$PWD/Powershell.ps1";
    $powershellCoreProfilePath = "$HOME/Documents/PowerShell/Microsoft.PowerShell_profile.ps1";
    Remove-Item $powershellCoreProfilePath -Force;
    New-Item -ItemType SymbolicLink -Path "$powershellCoreProfilePath" -Target "$PWD/powershell.ps1";
    Copy-Item -Path "$HOME/Documents/PowerShell/Modules/*" -Destination "$HOME/Documents/WindowsPowerShell/Modules" -Recurse -Force;
    Write-Host "    ✅ Powershell" -ForegroundColor Green;

    $windowsTerminalSettings = "$env:LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json";
    Remove-Item $windowsTerminalSettings -Force;
    New-Item -ItemType SymbolicLink -Path $windowsTerminalSettings -Target "$PWD/windows-terminal.json";
    Write-Host "    ✅ Windows Terminal" -ForegroundColor Green;

    $spicetifyConfig = "$HOME/.spicetify/config.ini";
    Remove-Item $spicetifyConfig -Force;
    New-Item -ItemType SymbolicLink -Path $spicetifyConfig -Target "$PWD/Spicetify-CLI.ini";
    Write-Host "    ✅ Spicetify" -ForegroundColor Green;

    $gitConfig = "$HOME/.gitconfig";
    Remove-Item $gitConfig -Force;
    New-Item -ItemType SymbolicLink -Path $gitConfig -Target "$PWD/.gitconfig";
    Write-Host "    ✅ .gitconfig" -ForegroundColor Green;

    $npmrc = "$HOME/.npmrc";
    Remove-Item $npmrc -Force;
    New-Item -ItemType SymbolicLink -Path $npmrc -Target "$PWD/.npmrc";
    Write-Host "    ✅ .npmrc" -ForegroundColor Green;

    # $ueliConfig = "$env:APPDATA/ueli/config.json";
    # Remove-Item $ueliConfig -Force;
    # New-Item -ItemType SymbolicLink -Path $ueliConfig -Target "$PWD/ueli.json";
    # Write-Host "    ✅ Ueli" -ForegroundColor Green;

    $translucenTbConfig = "$env:APPDATA/TranslucentTB/config.cfg";
    Remove-Item $translucenTbConfig -Force;
    New-Item -ItemType SymbolicLink -Path $translucenTbConfig -Target "$PWD/TranslucentTB.cfg";
    Write-Host "    ✅ TranslucentTB" -ForegroundColor Green;

    $netSpeedMonitorConfig = "$env:APPDATA/NetSpeedMonitor/config.xml";
    Remove-Item $netSpeedMonitorConfig -Force;
    New-Item -ItemType SymbolicLink -Path $netSpeedMonitorConfig -Target "$PWD/NetSpeedMonitor.xml";
    Write-Host "    ✅ NetSpeedMonitor" -ForegroundColor Green;

    Copy-Item -Path "$PWD/Notepad++/Notepad++Themes/*" -Destination "$env:APPDATA/Notepad++/themes" -Recurse -Force;
    $notepadplusplusConfig = "$env:APPDATA/Notepad++/config.xml";
    Remove-Item $notepadplusplusConfig -Force;
    New-Item -ItemType SymbolicLink -Path $notepadplusplusConfig -Target "$PWD/notepad++/Notepad++.xml";
    Write-Host "    ✅ Notepad++" -ForegroundColor Green;
}


################# Execution #########################

#Requires -RunAsAdministrator

if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Host "❌ Install Powershell Core first and then run this from it." -ForegroundColor Red;
    exit;
}

$ErrorActionPreference = "SlientlyContinue";

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser;
Write-Host "✅ Execution Policy is now set to RemoteSigned." -ForegroundColor Green;

[void](InstallApps);
[void](InstallFonts);
[void](InstallPowerShellModules);
[void](CreateConfigsSymlink);

