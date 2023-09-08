function Set-EntraBetaDirSyncConfiguration {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", Mandatory = $true)][System.String] $AccidentalDeletionThreshold,
        [Parameter(ParameterSetName = "GetQuery")][System.String] $TenantId,
        [switch] $Force
    )

    PROCESS {
        $params = @{}
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
            $response = Update-MgBetaDirectoryOnPremiseSynchronization -OnPremisesDirectorySynchronizationId $OnPremisesDirectorySynchronizationId -BodyParameter $params
            $response
        }
        else {
            return
        }
    }
}
