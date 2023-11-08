<#
See ; https://getvpro.com/2023/11/07/a-simple-fast-method-to-id-eol-windows-server-oss-by-powershell/
#>

function Select-EOLOS {
    param (
        [string]$Title = 'Select the EOL Windows Server OS to scan for'
    )
    Clear-Host
    Write-Host "================ $Title ================"    
    Write-Host "`r"
    Write-Host "1: Press '1' Win 2012"
    Write-Host "`r"
    Write-Host "2: Press '2' Win 2016"
    Write-Host "`r"
    Write-Host "3: Press '3' Win 2019"
    Write-Host "`r"
    Write-Host "4: Press '4' Win 2022"
    Write-Host "`r"
    Write-Host "Q: Press 'Q' to quit"
}



do {
    Select-EOLOS
    Write-Host "`r"
    $input = Read-Host "Please make a selection"
    switch ($input) {

        '1' {
            Clear-Host
            $EOLOS = "Windows Server 2012"
        }

        '2' {
            Clear-Host
            $EOLOS = "Windows Server 2016"

        }

        '3' {
            Clear-Host
            $EOLOS = "Windows Server 2019"

        }

        '4' {
            Clear-Host
            $EOLOS = "Windows Server 2022"

        }

        'q' {
            Write-Warning "Script will now exit"
            EXIT
        }
    }

    "Selected EOL Windows OS is $EOLOS"
    Write-Host "`r"
    Pause
}
until ($input -ne $null)

Get-ADComputer -Filter "operatingsystem -like '$EOLOS*'"

$Assets = Get-ADComputer -Filter "operatingsystem -like '$EOLOS*' -and enabled -eq 'True'" -Properties Name,Operatingsystem,IPv4Address | Sort-Object -Property Operatingsystem | `
Select-Object -Property Name,Operatingsystem,OperatingSystemVersion,IPv4Address

$OutArray = @()

$AssetsTotal = $Assets | Measure | Select-Object -ExpandProperty Count
$AssetsLeft = $AssetsTotal

ForEach ($i in $Assets) {

    $VM = $i.Name  
    $OS = $i.Operatingsystem
    $IP = $i.IPv4Address
    
    write-host "Checking $VM"

    Write-Host "Checking $VM now" -ForegroundColor green
    write-host  "$AssetsLeft remaining to process.." -ForegroundColor cyan

    if (Test-Connection -ComputerName $VM -Count 1 -ErrorAction SilentlyContinue) {

        $Ping = "Online"
        
        write-host "$VM is online" -ForegroundColor Green        

    }
    
    Else {
        
        write-host "$VM is offline" -ForegroundColor yellow
        $Ping = "Offline"       

    }

    $OutArray += New-Object PSObject -property @{

    VM = $VM
    Ping = $Ping
    OS = $OS
    IP = $IP
    }

    $AssetsLeft --

}

$OutArray | Select VM, Ping, IP, OS | Out-GridView