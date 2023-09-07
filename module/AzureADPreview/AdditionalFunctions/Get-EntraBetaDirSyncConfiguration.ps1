function Get-EntraBetaDirSyncConfiguration {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][System.String] $TenantId
    )

    PROCESS {    
        $params = @{}
        $keysChanged = @{$TenantId = "OnPremisesDirectorySynchronizationId" }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($null -ne $PSBoundParameters["TenantId"]) {
            $params["OnPremisesDirectorySynchronizationId"] = $PSBoundParameters["TenantId"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = ((Get-MgBetaDirectoryOnPremiseSynchronization @params).configuration | Select-Object -Property AccidentalDeletionPrevention).AccidentalDeletionPrevention
        # Create a custom table
        $customTable = [PSCustomObject]@{
            "AccidentalDeletionThreshold" = $response.AlertThreshold
            "DeletionPreventionType"      = $response.SynchronizationPreventionType
        }
        $customTable | Format-Table
    }
}