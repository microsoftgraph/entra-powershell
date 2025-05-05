# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Test-EntraScript {
	<#
	.SYNOPSIS
		Checks, whether the provided script is using AzureAD commands that are not supported by Microsoft.Graph.Entra.
	
	.DESCRIPTION
		Checks, whether the provided script is using AzureAD commands that are not supported by Microsoft.Graph.Entra.
	
	.PARAMETER Path
		Path to the script file(s) to scan.
		Or name of the content, when also specifying -Content

	.PARAMETER Content
		Code content to scan.
		Used when scanning code that has no file representation (e.g. straight from a repository).

	.PARAMETER Quiet
		Only return $true or $false, based on whether the script could run under Microsoft.Graph.Entra ($true) or not ($false)
	
	.EXAMPLE
		PS C:\> Test-EntraScript -Path .\usercreation.ps1 -Quiet
		
		Returns whether the script "usercreation.ps1" could run under Microsoft.Graph.Entra

	.EXAMPLE
		PS C:\> Get-ChildItem -Path \\contoso.com\it\code -Recurse -Filter *.ps1 | Test-EntraScript

		Returns a list of all scripts that would not run under the Microsoft.Graph.Entra module, listing each issue with line and code.
	#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
		[Alias('FullName', 'Name')]
		[string[]]
		$Path,

		[Parameter(ValueFromPipelineByPropertyName = $true)]
		[string]
		$Content,

		[switch]
		$Quiet
	)

	begin {
		function Test-ScriptCommand {
			[CmdletBinding()]
			param (
				[Parameter(Mandatory = $true)]
				[Alias('FullName')]
				[string]
				$Name,

				[Parameter(Mandatory = $true)]
				[string]
				$Content,

				[switch]
				$Quiet,

				[AllowEmptyCollection()]
				[string[]]
				$RequiredCommands,

				[AllowEmptyCollection()]
				[string[]]
				$ForbiddenCommands
			)

			$ast = [System.Management.Automation.Language.Parser]::ParseInput($Content, [ref]$null, [ref]$null)
			$allCommands = $ast.FindAll({ $args[0] -is [System.Management.Automation.Language.CommandAst] }, $true)
			$allCommandNames = @($allCommands).ForEach{ $_.CommandElements[0].Value }

			$findings = @()
			foreach ($command in $allCommands) {
				if ($command.CommandElements[0].Value -notin $ForbiddenCommands) { continue }
				$findings += [PSCustomObject]@{
					PSTypeName = 'Microsoft.Graph.Entra.CommandRequirement'
					Name       = $Name
					Line       = $command.Extent.StartLineNumber
					Type       = 'UnsupportedCommand'
					Command    = $command.CommandElements[0].Value
					Code       = $command.Extent.Text
				}
			}
			foreach ($requiredCommand in $RequiredCommands) {
				if ($requiredCommand -notin $allCommandNames) { continue }
				$findings += [PSCustomObject]@{
					PSTypeName = 'Microsoft.Graph.Entra.CommandRequirement'
					Name       = $Name
					Line       = -1
					Type       = 'RequiredCommandMissing'
					Command    = $requiredCommand
					Code       = ''
				}
			}

			if (-not $Quiet) {
				$findings
				return
			}

			$findings -as [bool]
		}

		$testParam = @{
			Quiet             = $Quiet
			ForbiddenCommands = $script:MISSING_CMDS
		}
	}
	process {
		if ($Path -and $Content) {
			Test-ScriptCommand -Name @($Path)[0] -Content $Content
			return
		}
		foreach ($entry in $Path) {
			try { $resolvedPaths = Resolve-Path -Path $entry -ErrorAction Stop }
			catch {
				Write-Error $_
				continue
			}
	
			foreach ($resolvedPath in $resolvedPaths) {
				if (-not (Test-Path -Path $resolvedPath -PathType Leaf)) {
					Write-Warning "Not a file: $resolvedPath"
					continue
				}
	
				$scriptContent = (Get-Content -LiteralPath $resolvedPath) -join "`n"
				Test-ScriptCommand -Name $resolvedPath -Content $scriptContent @testParam
			}
		}
	}
}function Get-EntraAuthorizationPolicy {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id,
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
        [System.String[]] $Property
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand        
        $params["Uri"] = "/v1.0/policies/authorizationPolicy?"
        $params["Method"] = "GET"
    
        if($null -ne $PSBoundParameters["Id"])
        {
            $Id = $Id.Substring(0, 1).ToLower() + $Id.Substring(1)
            $Filter = "Id eq '$Id'"
            $f = '$' + 'Filter'
            $params["Uri"] += "&$f=$Filter"
        }
        if($null -ne $PSBoundParameters["Property"])
        {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
            $params["Uri"] += "&$properties"
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest @params -Headers $customHeaders | ConvertTo-Json | ConvertFrom-Json
        if($response){
            $policyList = @()
            foreach ($data in $response) {
                $policyType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphAuthorizationPolicy
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $policyType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $policyList += $policyType
            }
            $policyList 
        }
    }
}# ------------------------------------------------------------------------------

