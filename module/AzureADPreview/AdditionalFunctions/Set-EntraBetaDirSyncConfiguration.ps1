function Set-EntraBetaDirSyncConfiguration {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", Mandatory = $true)][System.String] $AccidentalDeletionThreshold,
        [Parameter(ParameterSetName = "GetQuery")][System.String] $TenantId
    )

    PROCESS {    
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
            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")
        }

        
        if ([string]::IsNullOrWhiteSpace($TenantId)) {
            $OnPremisesDirectorySynchronizationId = (get-MgBetaDirectoryOnPremiseSynchronization).Id
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
}