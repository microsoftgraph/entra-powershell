# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Test-EntraScript {
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
					PSTypeName = 'Microsoft.Entra.CommandRequirement'
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
					PSTypeName = 'Microsoft.Entra.CommandRequirement'
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
}