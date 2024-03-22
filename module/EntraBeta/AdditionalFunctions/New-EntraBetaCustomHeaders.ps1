# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function New-EntraBetaCustomHeaders {
    <#
    .SYNOPSIS
        Creates a custom header for use in telemetry.
    .DESCRIPTION
        THe custom header created is a User-Agent with header value "<PowerShell version> EntraPowershell/<EntraPowershell version> <Entra PowerShell command>"
    .EXAMPLE
        New-EntraBetaCustomHeaders -Command Get-EntraUser
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
		$Command
    )

    $basePath = (join-path $PSScriptRoot '../module/EntraBeta')
	$settingPath = join-path $basePath "./config/ModuleMetadata.json"
	$content = Get-Content -Path $settingPath | ConvertFrom-Json
	$psVersion = $global:PSVersionTable.PSVersion
	$entraVersion = $content.version
	$userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion $Command"
	$customHeaders = New-Object 'system.collections.generic.dictionary[string,string]'
	$customHeaders["User-Agent"] = $userAgentHeaderValue

	$customHeaders
}