# Additional Functions

The module allows to create additional functions that will be included in the module along with the regular compatibility adapter commands, giving flexibility to create helper code for customers.

In order to add a functions just add the ps1 file into this folder (AdditionalFunctions) the ps1 file and function inside must have the same name, the same prefix has to be used for this functions unless is a special case. The generation process will add the code in the file into the main psm1 file.

Unit test is present to validate that the file name and the generated function are the same, will fail if the naming in different. Additionaly new function must add pester unit testing for any command that is added.

For example `Test-EntraScript.ps1` command as a reference of a working function

```PowerShell
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
    
                $scriptContent = (Get-Content -LiteralPath $resolvedPath) -join ""
                Test-ScriptCommand -Name $resolvedPath -Content $scriptContent @testParam
            }
        }
    }
}
```

Usage

```PowerShell
Import-Module Microsoft.Graph.Entra
Test-EntraScript ".\MyScript"
```


