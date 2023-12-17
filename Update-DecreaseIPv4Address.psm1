function Update-DecreaseIPv4Address {
    <#
    .SYNOPSIS
        Decrease the IP address with 1 or more.
    .DESCRIPTION
        This function decreases the IP address with 1 or more.
    .PARAMETER IPAddress
        The IP address to update.
    .PARAMETER Count
        Default 1 but it can update with a number.
    .EXAMPLE
        Update-DecreaseIPv4Address -IPAddress "192.168.1"                                        # Return 0.0.0.0 - Wrong input format
    .EXAMPLE
        Update-DecreaseIPv4Address -IPAddress "192.168.1.255"                                    # Subtract 1 from IP address
    .EXAMPLE
        Update-DecreaseIPv4Address -IPAddress "192.168.1.255" -Count 10                          # Subtract 10 from IP address
    .NOTES
        Author: Henrik Bruun  Github.com @Henrik-Bruun
        Version: 1.0 2023 December.
    #>

    param (
        [string]$IPAddress,
        [int]$Count = 1
    )
    $ipv4Pattern = "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
    
    if ($IPAddress -match $ipv4Pattern) {
    
    $Octet1 = ($IPAddress -split '\.')[0] -as [int]
    $Octet2 = ($IPAddress -split '\.')[1] -as [int]
    $Octet3 = ($IPAddress -split '\.')[2] -as [int]
    $Octet4 = ($IPAddress -split '\.')[3] -as [int]

    for ($i = 0; $i -lt $Count; $i++) {
        $Octet4--
        if ($Octet4 -lt 0) {
            $Octet4 = 255
            $Octet3--
        }

        if ($Octet3 -lt 0) {
            $Octet3 = 255
            $Octet2--
        }

        if ($Octet2 -lt 0) {
            $Octet2 = 255
            $Octet1--
        }

        if ($Octet1 -lt 0) {
            $Octet4 = 255
            $Octet3 = 255
            $Octet2 = 255
            $Octet1 = 255
        }
    }

    $resultIPAddress = "$Octet1.$Octet2.$Octet3.$Octet4"
    Write-Output $resultIPAddress.ToString()
    } else {
        Write-Output "0.0.0.0"
    }
}
