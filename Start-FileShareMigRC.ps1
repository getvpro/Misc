<#

.FUNCTIONALITY
Robocopy script to copy files/folders from old to new filers

.SYNOPSIS

.NOTES
Change log

Nov 24, 2024
-Initial upload to gitub

.DESCRIPTION
Author oreynolds@gmail.com

.EXAMPLE
./Start-FileShareMigRC.ps1

.NOTES

.Link
N/A

#>

If ($psISE) {

    $CurrentDir = Split-path $psISE.CurrentFile.FullPath
}

Else {

    $CurrentDir = split-path -parent $MyInvocation.MyCommand.Definition

}

$ShortDate = (Get-Date).ToString('MM-dd-yyyy')
$LogTimeStamp = (Get-Date).ToString('MM-dd-yyyy-hhmm-tt')
$ScriptLog = "$CurrentDir\Logs\FilerMig-$Env:Username-$LogTimeStamp-"

$ScriptStart = Get-Date

##
Function Write-CustomLog {
    Param(
    [String]$ScriptLog,    
    [String]$Message,
    [String]$Level
    
    )

    switch ($Level) { 
        'Error' 
            {
            $LevelText = 'ERROR:' 
            $Message = "$(Get-Date): $LevelText Ran from $Env:computername by $($Env:Username): $Message"
            Write-host $Message -ForegroundColor RED            
            } 
        
        'Warn'
            { 
            $LevelText = 'WARNING:' 
            $Message = "$(Get-Date): $LevelText Ran from $Env:computername by $($Env:Username): $Message"
            Write-host $Message -ForegroundColor YELLOW            
            } 

        'Info'
            { 
            $LevelText = 'INFO:' 
            $Message = "$(Get-Date): $LevelText Ran from $Env:computername by $($Env:Username): $Message"
            Write-host $Message -ForegroundColor GREEN            
            } 

        }
        
        Add-content -value "$Message" -Path $ScriptLog
}

##  Functions

##  End functions

$OutArray = @()


IF (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    write-warning "not started as elevated session, exiting"
    EXIT

}

### Edit lines 96/97 as required

$ProfSrc = "\\OLD-SERVER"
$ProfDest = "\\NEW-SERVER"

Write-host "Starting file copy for first folder in 5 seconds"
start-sleep -Seconds 5

### Edit lines below as required for all your shares

$ScriptLog = "$CurrentDir\Logs\FilerMig-$Env:Username-$LogTimeStamp-" + "SHARE1.log"
Write-CustomLog -Level INFO -ScriptLog $ScriptLog -Message "Starting robocopy for $ProfSrc\Share1"
robocopy "$ProfSrc\Share1" "$ProfDest\Share1" /b /mir /mt /r:0 /w:0 /Z /S /TEE /COPY:DOTS /LOG+:$ScriptLog
Write-CustomLog -Level INFO -ScriptLog $ScriptLog -Message "Completed 1 of 2 share copies 'SHARE1', moving to second share copy"

$ScriptLog = "$CurrentDir\Logs\FilerMig-$Env:Username-$LogTimeStamp-" + "SHARE2.log"
Write-CustomLog -Level INFO -ScriptLog $ScriptLog -Message "Starting robocopy for $ProfSrc\Share1"
robocopy "$ProfSrc\Share2" "$ProfDest\Share2" /b /mir /mt /r:0 /w:0 /Z /S /TEE /COPY:DOTS /LOG+:$ScriptLog
Write-CustomLog -Level INFO -ScriptLog $ScriptLog -Message "Completed 2 of 2 share copies 'SHARE2', moving to second share copy"

#Logging end

$ScriptEnd = Get-Date

$TotalScriptTime = $ScriptEnd - $ScriptStart | Select-object Hours, Minutes, Seconds
$Hours = $TotalScriptTime | Select-object -expand Hours
$Mins = $TotalScriptTime | Select-object -expand Minutes
$Seconds = $TotalScriptTime | Select-object -expand Seconds

Write-CustomLog -Level INFO -ScriptLog $ScriptLog -Message "Script completed in $Hours hours, $Mins mins and $Seconds seconds"