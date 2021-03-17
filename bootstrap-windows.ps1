################# Definitions #########################

function RefreshEnvs {
    $ENV:path = [System.ENVironment]::GetENVironmentVariable("Path", "Machine") + ";" + [System.ENVironment]::GetENVironmentVariable("Path", "User")
}

function InstallApps {
    Write-Host "- Installing Apps..." -ForegroundColor Cyan;

    if (-Not (Get-Command scoop)) {
        Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh');
        Write-Host "    ✅ Scoop" -ForegroundColor Green;
        RefreshEnvs;
    }

    scoop bucket add spotify "https://github.com/TheRandomLabs/Scoop-Spotify.git";
    scoop bucket add nerd-fonts;
    scoop bucket add extras;

    scoop install vcredist;
    Write-Host "    ✅ VCRedist" -ForegroundColor Green;

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
    RefreshEnvs;

    scoop install vscode --global;
    Write-Host "    ✅ Visual Studio Code" -ForegroundColor Green;

    scoop install neovim --global;
    Write-Host "    ✅ Neovim" -ForegroundColor Green;

    scoop install windows-terminal --global;
    Write-Host "    ✅ Windows Terminal" -ForegroundColor Green;

    scoop install nvm --global;
    Write-Host "    ✅ NodeJS Version Manager (nvm)" -ForegroundColor Green;
    RefreshEnvs;

    nvm install latest;
    Write-Host "    ✅ NodeJS Latest" -ForegroundColor Green;

    scoop install rust --global;
    Write-Host "    ✅ Rust" -ForegroundColor Green;

    scoop install python --global;
    Write-Host "    ✅ Python" -ForegroundColor Green;

    scoop install nuget --global;
    Write-Host "    ✅ NuGet" -ForegroundColor Green;

    git clone "https://github.com/microsoft/vcpkg" "$ENV:LOCALAPPDATA/vcpkg";
    &"$ENV:LOCALAPPDATA/vcpkg/bootstrap-vcpkg.bat" -disableMetrics
    Write-Host "    ✅ vcpkg" -ForegroundColor Green;

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

    scoop install trafficmonitor;
    Write-Host "    ✅ TrafficMonitor" -ForegroundColor Green;

    scoop install 7zip;
    Write-Host "    ✅ 7-Zip" -ForegroundColor Green;

    scoop install steam --global;
    Write-Host "    ✅ Steam" -ForegroundColor Green;
}

function InstallFonts {
    Write-Host "- Installing Fonts..." -ForegroundColor Cyan;


    scoop install FiraCode --global;
    Write-Host "    ✅ FiraCode" -ForegroundColor Green;

    scoop install FiraCode-NF --global;
    Write-Host "    ✅ FiraCode-NF" --global; -ForegroundColor Green;
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Console\TrueTypeFont' -Name '000' -Value 'FiraCode NF'; # a fix for Terminal-Icons module

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
    New-Item -ItemType SymbolicLink -Path "$normalPowershellProfilePath" -Target "$PWD/windows/powershell.ps1";
    $powershellCoreProfilePath = "$HOME/Documents/PowerShell/Microsoft.PowerShell_profile.ps1";
    Remove-Item $powershellCoreProfilePath -Force;
    New-Item -ItemType SymbolicLink -Path "$powershellCoreProfilePath" -Target "$PWD/windows/powershell.ps1";
    Copy-Item -Path "$HOME/Documents/PowerShell/Modules/*" -Destination "$HOME/Documents/WindowsPowerShell/Modules" -Recurse -Force;
    Write-Host "    ✅ Powershell" -ForegroundColor Green;

    $windowsTerminalSettings = "$ENV:LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json";
    Remove-Item $windowsTerminalSettings -Force;
    New-Item -ItemType SymbolicLink -Path $windowsTerminalSettings -Target "$PWD/windows/windows-terminal.json";
    Write-Host "    ✅ Windows Terminal" -ForegroundColor Green;

    $spicetifyConfig = "$HOME/.spicetify/config.ini";
    Remove-Item $spicetifyConfig -Force;
    New-Item -ItemType SymbolicLink -Path $spicetifyConfig -Target "$PWD/windows/spicetify-cli.ini";
    Write-Host "    ✅ Spicetify" -ForegroundColor Green;

    $gitConfig = "$HOME/.gitconfig";
    Remove-Item $gitConfig -Force;
    New-Item -ItemType SymbolicLink -Path $gitConfig -Target "$PWD/shared/.gitconfig";
    Write-Host "    ✅ .gitconfig" -ForegroundColor Green;

    $npmrc = "$HOME/.npmrc";
    Remove-Item $npmrc -Force;
    New-Item -ItemType SymbolicLink -Path $npmrc -Target "$PWD/windows/.npmrc";
    Write-Host "    ✅ .npmrc" -ForegroundColor Green;

    # TODO:
    # $ueliConfig = "$ENV:APPDATA/ueli/config.json";
    # Remove-Item $ueliConfig -Force;
    # # Note: Ueli doesn't seem to handle symlinks well, so we move the whole config file
    # Copy-Item -Path "$PWD/windows/ueli.json" -Destination $ueliConfig -Force;
    # Write-Host "    ✅ Ueli" -ForegroundColor Green;

    $translucenTbConfig = "$ENV:APPDATA/TranslucentTB/config.cfg";
    Remove-Item $translucenTbConfig -Force;
    New-Item -ItemType SymbolicLink -Path $translucenTbConfig -Target "$PWD/translucent-tb.cfg";
    Write-Host "    ✅ TranslucentTB" -ForegroundColor Green;

    Copy-Item -Path "$PWD/windows/notepad++/themes/*" -Destination "$ENV:APPDATA/Notepad++/themes" -Recurse -Force;
    $notepadplusplusConfig = "$ENV:APPDATA/Notepad++/config.xml";
    Remove-Item $notepadplusplusConfig -Force;
    New-Item -ItemType SymbolicLink -Path $notepadplusplusConfig -Target "$PWD/windows/notepad++/config.xml";
    Write-Host "    ✅ Notepad++" -ForegroundColor Green;

    $trafficMonitorConfig = "$ENV:APPDATA/TrafficMonitor/config.ini";
    Remove-Item $trafficMonitorConfig -Force;
    New-Item -ItemType SymbolicLink -Path $trafficMonitorConfig -Target "$PWD/windows/traffic-monitor.ini";
    Write-Host "    ✅ Traffic Monitor" -ForegroundColor Green;

    $starShipConfig = "$HOME/.config/starship.toml";
    Remove-Item $starShipConfig -Force;
    New-Item -ItemType SymbolicLink -Path $starShipConfig -Target "$PWD/shared/starship.toml";
    Write-Host "    ✅ Starship" -ForegroundColor Green;

    $nvimConfig = "$ENV:LOCALAPPDATA/nvim/init.vim";
    Remove-Item $nvimConfig -Force;
    New-Item -ItemType SymbolicLink -Path $nvimConfig -Target "$PWD/shared/neovim.vim";
    Write-Host "    ✅ Neovim" -ForegroundColor Green;
}


################# Execution #########################

if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Host "❌ Install Powershell Core first and then run this from it." -ForegroundColor Red;
    exit;
}

#Requires -RunAsAdministrator

$ErrorActionPreference = "SlientlyContinue";

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser;
Write-Host "✅ Execution Policy is now set to RemoteSigned." -ForegroundColor Green;

[void](InstallApps);
[void](InstallFonts);
[void](InstallPowerShellModules);
[void](CreateConfigsSymlink);

