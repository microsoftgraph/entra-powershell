# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraContext {
    [CmdletBinding(DefaultParameterSetName='UserParameterSet', HelpUri='https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.authentication/get-mgcontext')]
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
            $result = $steppablePipeline.Process($_)

            # Add the EntraVersion property to the output object


            $result | Add-Member -MemberType NoteProperty -Name "EntraVersion" -Value "0.19.0" -Force
            
            
        return $result

            
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
}
