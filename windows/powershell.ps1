using namespace Microsoft.PowerShell;

#region Imports
Import-Module posh-git
Import-Module Terminal-Icons
Import-Module 'C:\Users\amrba\AppData\Roaming\vcpkg\scripts\posh-vcpkg'
Invoke-Expression (&starship init powershell)
#endregion

#region PSReadLineOptions
Set-Variable PSReadLineOptions -Scope Script -Option Constant -Value @{
    PredictionSource              = "History"
    HistoryNoDuplicates           = $true
    HistorySearchCursorMovesToEnd = $true
    Colors                        = @{
        Operator         = "Yellow"
        Command          = "Yellow"
        Parameter        = "Blue"
        Member           = "DarkYellow"
        Selection        = "$([char]0x1b)[36;7;238m"
        InlinePrediction = "#c9c9c7"
    }
}
Set-PSReadLineOption @PSReadLineOptions
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord
Set-PSReadLineKeyHandler -Key Ctrl+Backspace -Function BackwardKillWord
Set-PSReadLineKeyHandler -Key Alt+Backspace -Function BackwardKillWord
Set-PSReadLineKeyHandler -Key F1 -Function WhatIsKey
Set-PSReadLineKeyHandler -Key Ctrl+Shift+LeftArrow -Function SelectBackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+Shift+RightArrow -Function SelectForwardWord
Set-PSReadLineKeyHandler -Key Ctrl+UpArrow -BriefDescription GoBack -LongDescription "Go back one directory" -ScriptBlock {
    Set-Location -
    [PSConsoleReadLine]::AcceptLine()
}
#enregion

#region private functions
function __ls { Get-ChildItem | Format-Wide };
function __commit_date { git commit -m (Get-Date -UFormat '%D %I:%M %p') };
function __refresh_envs { $env:path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User") };
#endregion

#region Aliases
Set-Alias vim nvim;
Set-Alias touch New-Item;
Set-Alias ls __ls -Option AllScope;
Set-Alias lsa  Get-ChildItem;
Set-Alias commit-date __commit_date;
Set-Alias refresh-envs __refresh_envs;
#endregion
