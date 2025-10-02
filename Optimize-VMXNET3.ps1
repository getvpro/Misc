$vmxnet3Adapters = Get-NetAdapter -IncludeHidden | Where-Object { $_.InterfaceDescription -like '*VMXNET3*' }

foreach ($adapter in $vmxnet3Adapters) {
    $name = $adapter.Name

    Write-Host "Disabling Checksum Offload on adapter $name"
    Disable-NetAdapterChecksumOffload -Name $name -IpIPV4 -TcpIPV4 -TcpIPV6 -UdpIPV4 -UdpIPV6 -NoRestart

    Write-Host "Disabling LSO on adapter $name"
    Disable-NetAdapterLso -Name $name -IPv4 -IPv6 -NoRestart

    Write-Host "Disabling Encapsulated Packet Task Offload on adapter $name"
    Disable-NetAdapterEncapsulatedPacketTaskOffload -Name $name -NoRestart

    Write-Host "Disabling IPsec Offload on adapter $name"
    Disable-NetAdapterIPsecOffload -Name $name -NoRestart

    Write-Host "Disabling RSS on adapter $name"
    Disable-NetAdapterRss -Name $name -NoRestart

    Write-Host "Disabling RSC on adapter $name"
    Disable-NetAdapterRsc -Name $name -IPv4 -IPv6 -NoRestart

    Write-Host "Disabling Power Management on adapter $name"
    Disable-NetAdapterPowerManagement -Name $name -NoRestart

    Write-Host "Disabling USO on adapter $name"
    Disable-NetAdapterUso -Name $name -IPv4 -IPv6 -NoRestart

    Write-Host "Setting advanced properties on adapter $name"
    Set-NetAdapterAdvancedProperty -Name $name -DisplayName "Packet Priority & VLAN" -DisplayValue "Packet Priority & VLAN Disabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $name -DisplayName "Priority / VLAN tag" -DisplayValue "Priority & VLAN Disabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $name -DisplayName "Interrupt Moderation" -DisplayValue "Disabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $name -DisplayName "Offload IP Options" -DisplayValue "Disabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $name -DisplayName "Offload TCP Options" -DisplayValue "Disabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $name -DisplayName "Offload tagged traffic" -DisplayValue "Disabled" -NoRestart
    Set-NetAdapterAdvancedProperty -Name $name -DisplayName "Interrupt Coalescing Scheme Mode" -DisplayValue "Disabled" -NoRestart

    Write-Host "Disabling advanced Power Management features on adapter $name"
    Disable-NetAdapterPowerManagement -Name $name -D0PacketCoalescing -DeviceSleepOnDisconnect -NSOffload -SelectiveSuspend -RsnRekeyOffload -NoRestart
}
