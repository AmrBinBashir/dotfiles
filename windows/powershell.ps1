using namespace Microsoft.PowerShell;

#region Imports
# Chocolatey profile
Import-Module Get-ChildItemColor
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

#region Aliases and Functions
function Projects { Set-Location "D:/Development/Projects" }
function RefreshEnvs { $env:path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User") }
function Vim { nvim $args }
function Touch { New-Item $args }
function Commit-Date { git commit -m (Get-Date -UFormat '%D %I:%M %p') }

If (-Not (Test-Path Variable:PSise)) {
    # Only run this in the console and not in the ISE
    Set-Alias lsa Get-ChildItem -Option AllScope
}
#endregion
