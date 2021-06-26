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

    # git is required for buckets
    scoop install git --global;
    Write-Host "    ✅ git" -ForegroundColor Green;
    RefreshEnvs;

    scoop bucket add spotify "https://github.com/TheRandomLabs/Scoop-Spotify.git";
    scoop bucket add nerd-fonts;
    scoop bucket add extras;

    scoop install vcredist --global;
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

    scoop install windows-terminal --global;
    Write-Host "    ✅ Windows Terminal" -ForegroundColor Green;

    scoop install autohotkey;
    Write-Host "    ✅ AutoHotKey" -ForegroundColor Green;

    scoop install mailspring;
    Write-Host "    ✅ Mailspring" -ForegroundColor Green;

    scoop install qbittorrent --global;
    Write-Host "    ✅ qBittorrent" -ForegroundColor Green;

    scoop install vlc --global;
    Write-Host "    ✅ VLC" -ForegroundColor Green;

    scoop install rainmeter;
    Write-Host "    ✅ Rainmeter" -ForegroundColor Green;

    scoop install everything --global;
    Write-Host "    ✅ Everything" -ForegroundColor Green;

    scoop install taskbarx;
    Write-Host "    ✅ TaskbarX" -ForegroundColor Green;

    scoop install trafficmonitor;
    Write-Host "    ✅ TrafficMonitor" -ForegroundColor Green;

    scoop install instant-eyedropper;
    Write-Host "    ✅ Instant Eyedropper" -ForegroundColor Green;

    scoop install 7zip --global;
    Write-Host "    ✅ 7-Zip" -ForegroundColor Green;

    scoop install neovim;
    Write-Host "    ✅ Neovim" -ForegroundColor Green;

    scoop install nvm;
    Write-Host "    ✅ NodeJS Version Manager (nvm)" -ForegroundColor Green;
    RefreshEnvs;

    nvm install latest;
    nvm use $(nvm list);
    Write-Host "    ✅ NodeJS Latest" -ForegroundColor Green;
    RefreshEnvs;

    git clone "https://github.com/microsoft/vcpkg" "$ENV:LOCALAPPDATA/vcpkg";
    &"$ENV:LOCALAPPDATA/vcpkg/bootstrap-vcpkg.bat" -disableMetrics
    Write-Host "    ✅ vcpkg" -ForegroundColor Green;

    scoop install yarn;
    Write-Host "    ✅ Yarn" -ForegroundColor Green;

    npm install -g pnpm
    Write-Host "    ✅ pnpm" -ForegroundColor Green;

    #######
    # 1. rustup
    # 2. vscode
    # 3. steam
    # 4. ueli
    # 5. modern flyouts
    # 6. vivaldi
    # 7. cmake

}


function InstallFonts {
    Write-Host "- Installing Fonts..." -ForegroundColor Cyan;


    scoop install FiraCode --global;
    Write-Host "    ✅ FiraCode" -ForegroundColor Green;

    scoop install FiraCode-NF --global;
    Write-Host "    ✅ FiraCode-NF" -ForegroundColor Green;

}

function InstallPowerShellModules {
    Write-Host "- Installing Powershell Modules..." -ForegroundColor Cyan;

    if ((Get-Module PowerShellGet).Version -le 1.6) {
        Install-Module -Name PowerShellGetGet -Force;
        Write-Host "    ✅ PowerShellGet" -ForegroundColor Green;
    }

    pwsh -Noprofile -Command "Install-Module PSReadLine -Force -SkipPublisherCheck -AllowPrerelease";
    Write-Host "    ✅ PSReadLine" -ForegroundColor Green;

    Install-Module -Name Terminal-Icons -Repository PSGallery;
    Write-Host "    ✅ Terminal-Icons" -ForegroundColor Green;

    Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force;
    Write-Host "    ✅ posh-git" -ForegroundColor Green;
}

function CreateConfigsSymlink {
    Write-Host "- Creating symlinks for config files..." -ForegroundColor Cyan;

    @(
        [PSCustomObject]@{destFolder = "$HOME\Documents\WindowsPowerShell\"; destFile = "Microsoft.PowerShell_profile.ps1"; file = "$PWD/windows/powershell.ps1" },
        [PSCustomObject]@{destFolder = "$HOME\Documents\PowerShell\"; destFile = "Microsoft.PowerShell_profile.ps1"; file = "$PWD/windows/powershell.ps1" },
        [PSCustomObject]@{destFolder = "$Env:LOCALAPPDATA\Microsoft\Windows Terminal\"; destFile = "settings.json"; file = "$PWD/windows/windows-terminal.json" },
        [PSCustomObject]@{destFolder = "$HOME\.spicetify\"; destFile = "config-xpui.ini"; file = "$PWD/windows/spicetify-cli.ini" },
        [PSCustomObject]@{destFolder = "$HOME\.config\"; destFile = "starship.toml"; file = "$PWD/shared/starship.toml" },
        [PSCustomObject]@{destFolder = "$HOME\"; destFile = ".gitconfig"; file = "$PWD/shared/.gitconfig" },
        [PSCustomObject]@{destFolder = "$Env:LOCALAPPDATA\nvim\"; destFile = "init.vim"; file = "$PWD/shared/neovim.vim" }
    ) | ForEach-Object {
        if ($_.destFolder -ne $HOME) {
            New-Item -Path $_.destFolder -ItemType Directory -Force;
        }

        $dest = $_.destFolder + $_.destFile;
        Remove-Item -Path $dest  -Force;
        New-Item -ItemType SymbolicLink -Path $dest -Target $_.file;
        Write-Host "    ✅ $($_.file)" -ForegroundColor Green;

    };

}

########

if ($PSVersionTable.PSEdition -ne "Core") {
    Write-Host "❌ Install Powershell Core first then use it to run the script." -ForegroundColor Red;
    exit;
}

# Requires -RunAsAdministrator

$ErrorActionPreference = "SlientlyContinue";

# Set-ExecutionPolicy Bypass -Scope CurrentUser;
# Write-Host "✅ Execution Policy is now set to Bypass." -ForegroundColor Green;

# [void](InstallApps);
# [void](InstallFonts);
# [void](InstallPowerShellModules);
[void](CreateConfigsSymlink);

