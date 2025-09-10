<#

.FUNCTIONALITY
Captures how long it takes to launch MS teams and MS Office

.SYNOPSIS

.NOTES
Change log

Sept 9, 2025
-Initial version

Sept 10, 2025
-Updated to dynamically capture MS teams path

.DESCRIPTION
Author oreynolds@gmail.com

.EXAMPLE
./Get-MS365LaunchTimes.ps1

.NOTES

.Link
https://github.com/getvpro/Misc/blob/main/Get-MS365LaunchTimes.ps1
#>


Add-Type @"
using System;
using System.Runtime.InteropServices;
public class User32 {
    [DllImport("user32.dll", SetLastError=true)]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
}
"@

write-host "test #1 MS Teams" -ForegroundColor Green

$teamsExeName = "ms-teams.exe"
$exePath = (Get-AppxPackage | where {$_.Name -contains "MSTeams"}).InstallLocation + "\$teamsExeName"

$App = ($exePath.Split("\"))[-1]

Write-Warning "Force closing $App and waiting 1 second"

IF (Get-Process -Name $App.Split(".")[0] -ErrorAction SilentlyContinue) {

    Get-Process -Name $App.Split(".")[0] | Stop-Process

}

Start-Sleep -Seconds 1

$process = Start-Process -FilePath $exePath -PassThru
$startTime = Get-Date

# Helper function to check if ms-teams.exe process has a main window
function Get-WindowHandle {
    $Proc = Get-Process | Where-Object { 
        try { $_.MainModule.ModuleName -ieq "ms-teams.exe" } catch { $false }
    }

    foreach ($i in $Proc) {
        # Check if the process has a main window handle
        if ($i.MainWindowHandle -ne 0) {
            return $i.MainWindowHandle
        }
    }
    return 0
}

while ($true) {
    Start-Sleep -Milliseconds 200
    $windowHandle = Get-WindowHandle
    if ($windowHandle -ne 0) { break }
    # Optional timeout logic here
}

$endTime = Get-Date
$elapsed = $endTime - $startTime
Write-host  "Launch time until $App window appeared: $($elapsed.TotalSeconds) seconds" -ForegroundColor Cyan

### Outlook

write-host "test #2 MS outlook" -ForegroundColor Green

$exePath = "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
$App = ($exePath.Split("\"))[-1]

Write-Warning "Force closing $App and waiting 1 second"

IF (Get-Process -Name $App.Split(".")[0] -ErrorAction SilentlyContinue) {

    Get-Process -Name $App.Split(".")[0] | Stop-Process

}

Start-Sleep -Seconds 1

$process = Start-Process -FilePath $exePath -PassThru
$startTime = Get-Date

# Helper function to check if ms-teams.exe process has a main window
function Get-WindowHandle {
    $Proc = Get-Process | Where-Object { 
        try { $_.MainModule.ModuleName -ieq "ms-teams.exe" } catch { $false }
    }

    foreach ($i in $Proc) {
        # Check if the process has a main window handle
        if ($i.MainWindowHandle -ne 0) {
            return $i.MainWindowHandle
        }
    }
    return 0
}

while ($true) {
    Start-Sleep -Milliseconds 200
    $windowHandle = Get-WindowHandle
    if ($windowHandle -ne 0) { break }
    # Optional timeout logic here
}

$endTime = Get-Date
$elapsed = $endTime - $startTime
Write-host  "Launch time until $App window appeared: $($elapsed.TotalSeconds) seconds" -ForegroundColor Cyan

