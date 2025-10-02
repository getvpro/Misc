Disable-NetAdapterChecksumOffload -Name "*" -IncludeHidden -IpIPV4 -TcpIPV4 -TcpIPV6 -UdpIPV4 -UdpIPV6 -NoRestart
Disable-NetAdapterLso -Name "*" -IncludeHidden -IPv4 -IPv6 -NoRestart
Disable-NetAdapterEncapsulatedPacketTaskOffload -Name "*" -IncludeHidden -NoRestart
Disable-NetAdapterIPsecOffload -Name "*" -IncludeHidden -NoRestart
Disable-NetAdapterRss -Name "*" -IncludeHidden -NoRestart
Disable-NetAdapterRsc -Name "*" -IncludeHidden -IPv4 -IPv6 -NoRestart
Disable-NetAdapterPowerManagement -Name "*" -NoRestart
Disable-NetAdapterUso -Name "*" -IncludeHidden -IPv4 -IPv6 -NoRestart
Set-NetAdapterAdvancedProperty -Name "*" -IncludeHidden -DisplayName "Packet Priority & VLAN" -DisplayValue "Packet Priority & VLAN Disabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "*" -IncludeHidden -DisplayName "Priority / VLAN tag" -DisplayValue "Priority & VLAN Disabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "*" -IncludeHidden -DisplayName "Interrupt Moderation" -DisplayValue "Disabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "*" -IncludeHidden -DisplayName "Offload IP Options" -DisplayValue "Disabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "*" -IncludeHidden -DisplayName "Offload TCP Options" -DisplayValue "Disabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "*" -IncludeHidden -DisplayName "Offload tagged traffic" -DisplayValue "Disabled" -NoRestart
Set-NetAdapterAdvancedProperty -Name "*" -IncludeHidden -DisplayName "Interrupt Coalescing Scheme Mode" -DisplayValue "Disabled" -NoRestart
Disable-NetAdapterPowerManagement -Name "*" -IncludeHidden  -D0PacketCoalescing -DeviceSleepOnDisconnect -NSOffload -SelectiveSuspend -RsnRekeyOffload