Install-WindowsFeature -Name 'DHCP' –IncludeManagementTools
Add-DhcpServerV4Scope -Name "DHCP Scope" -StartRange 192.168.1.150 -EndRange 192.168.1.200 -SubnetMask 255.255.255.0
Set-DhcpServerV4OptionValue -DnsServer 192.168.1.10
Set-DhcpServerv4Scope -ScopeId 192.168.1.10 -LeaseDuration 1.00:00:00
Restart-service dhcpserver