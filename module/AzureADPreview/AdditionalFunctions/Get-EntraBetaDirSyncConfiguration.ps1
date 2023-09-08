function Get-EntraBetaDirSyncConfiguration {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][System.String] $TenantId
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
        $response = ((Get-MgBetaDirectoryOnPremiseSynchronization @params -ErrorVariable Eq -erroraction SilentlyContinue).configuration | Select-Object -Property AccidentalDeletionPrevention).AccidentalDeletionPrevention
        # Create a custom table
        if ($null -ne $eq) {
            write-error "Get-EntraBetaDirSyncConfiguration : Cannot bind parameter 'TenantId'. Cannot convert value `"$($params["OnPremisesDirectorySynchronizationId"])`" to type `"System.Guid`". Error: `"Guid should contain 32 digits with 4 dashes (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx).`"
            "
        }
        else {
            $customTable = [PSCustomObject]@{
                "AccidentalDeletionThreshold" = $response.AlertThreshold
                "DeletionPreventionType"      = $response.SynchronizationPreventionType
            }
            $customTable | Format-Table
        }
    }
}