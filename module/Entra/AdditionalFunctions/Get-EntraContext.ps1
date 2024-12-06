# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraContext {
    [CmdletBinding(DefaultParameterSetName='UserParameterSet', HelpUri='https://learn.microsoft.com/powershell/module/microsoft.graph.entra/get-entracontext')]
    param()

    begin {
        try {
            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
                $PSBoundParameters['OutBuffer'] = 1
            }

            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.Graph.Authentication\Get-MgContext', [System.Management.Automation.CommandTypes]::Cmdlet)
            $scriptCmd = {& $wrappedCmd @PSBoundParameters }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)
        } catch {
            throw
        }
    }

    process {
        try {
            $steppablePipeline.Process($_)
        } catch {
            throw
        }
    }

    end {
        try {
            $steppablePipeline.End()
        } catch {
            throw
        }
    }

    clean {
        if ($null -ne $steppablePipeline) {
            $steppablePipeline.Clean()
        }
    }

    # Add the Entra PowerShell version to the output
    $context = Get-MgContext
    $context | Add-Member -MemberType NoteProperty -Name "EntraPowerShellVersion" -Value (Get-Module -Name Microsoft.Graph.Entra).Version.ToString() -Force
    $context
}

Set-Alias -Name Get-EntraCurrentSessionInfo -Value Get-EntraContext -Scope Global -Force