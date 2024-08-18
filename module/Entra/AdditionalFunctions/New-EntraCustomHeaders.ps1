# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function New-EntraCustomHeaders {
    <#
    .SYNOPSIS
        Creates a custom header for use in telemetry.
    .DESCRIPTION
        The custom header created is a User-Agent with header value "<PowerShell version> EntraPowershell/<EntraPowershell version> <Entra PowerShell command>"
    .EXAMPLE
        New-EntraCustomHeaders -Command Get-EntraUser
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
		$Command
    )
    
    $psVersion = $global:PSVersionTable.PSVersion
    $entraVersion = (Get-module Microsoft.Graph.Entra | select version).Version.ToString()
    $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion $Command"
    $customHeaders = New-Object 'system.collections.generic.dictionary[string,string]'
    $customHeaders["User-Agent"] = $userAgentHeaderValue
    
    $customHeaders
}
