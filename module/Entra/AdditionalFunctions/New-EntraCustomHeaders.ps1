<#
.SYNOPSIS
    A short one-line action-based description, e.g. 'Tests if a function is valid'
.DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>
function New-EntraCustomHeaders {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
		$Command
    )

    $basePath = (join-path $PSScriptRoot '../module/Entra')
	$settingPath = join-path $basePath "./config/ModuleMetadata.json"
	$content = Get-Content -Path $settingPath | ConvertFrom-Json
	$psVersion = $global:PSVersionTable.PSVersion
	$entraVersion = $content.version
	$userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion $Command"
	$customHeaders = New-Object 'system.collections.generic.dictionary[string,string]'
	$customHeaders["User-Agent"] = $userAgentHeaderValue

	$customHeaders
}