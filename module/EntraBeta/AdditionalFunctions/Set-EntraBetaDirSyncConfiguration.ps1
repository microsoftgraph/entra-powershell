# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Set-EntraBetaDirSyncConfiguration {
    [CmdletBinding(DefaultParameterSetName = 'SetAccidentalDeletionThreshold')]
    param (
        [Parameter(ParameterSetName = "SetAccidentalDeletionThreshold", ValueFromPipelineByPropertyName = $true, Mandatory = $true)][System.UInt32] $AccidentalDeletionThreshold,
        [Parameter(ParameterSetName = "All", ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId,
        [switch] $Force
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($null -ne $PSBoundParameters["AccidentalDeletionThreshold"]) {
            $AccidentalDeletionThreshold = $PSBoundParameters["AccidentalDeletionThreshold"]
        }
        if ($null -ne $PSBoundParameters["TenantId"]) {
            $TenantId = $PSBoundParameters["TenantId"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        if ($Force) {
            $decision = 0
        }
        else {
            $title = 'Confirm'
            $question = 'Do you want to continue?'
            $Suspend = New-Object System.Management.Automation.Host.ChoiceDescription "&Suspend", "S"
            $Yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Y"
            $No = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "S"
            $choices = [System.Management.Automation.Host.ChoiceDescription[]]($Yes, $No, $Suspend)
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        }

        if ($decision -eq 0) {
            if ([string]::IsNullOrWhiteSpace($TenantId)) {
                $OnPremisesDirectorySynchronizationId = (Get-MgBetaDirectoryOnPremiseSynchronization).Id
            }
            else {
                $OnPremisesDirectorySynchronizationId = $TenantId
            }
            $params = @{
                configuration = @{
                    accidentalDeletionPrevention = @{
                        synchronizationPreventionType = "enabledForCount"
                        alertThreshold                = $AccidentalDeletionThreshold
                    }
                }
            }
            $response = Update-MgBetaDirectoryOnPremiseSynchronization -Headers $customHeaders -OnPremisesDirectorySynchronizationId $OnPremisesDirectorySynchronizationId -BodyParameter $params
            $response
        }
        else {
            return
        }
    }
}
