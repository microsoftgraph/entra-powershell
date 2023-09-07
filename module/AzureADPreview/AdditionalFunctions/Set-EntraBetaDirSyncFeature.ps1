function Set-EntraBetaDirSyncFeature {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $true)][System.String] $Feature,
        [Parameter(ParameterSetName = "GetById", Mandatory = $true)][System.Boolean] $Enabled,
        [Parameter(ParameterSetName = "GetById")][System.String] $TenantId
    )

    PROCESS {    
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $Verbose = $Null
        }
        if ($null -ne $PSBoundParameters["Feature"]) {
            $Feature = $PSBoundParameters["Feature"] + "Enabled"
        }
        if ($null -ne $PSBoundParameters["Enabled"]) {
            $Enabled = $PSBoundParameters["Enabled"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        if ([string]::IsNullOrWhiteSpace($TenantId)) {
            $OnPremisesDirectorySynchronizationId = (get-MgBetaDirectoryOnPremiseSynchronization).Id
        }
        else {
            $OnPremisesDirectorySynchronizationId = $TenantId
        }
        $body = @{ 
            features = @{ $Feature = $Enabled } 
        } 
        $body = $body | ConvertTo-Json 
        $response = Update-MgBetaDirectoryOnPremiseSynchronization -OnPremisesDirectorySynchronizationId $OnPremisesDirectorySynchronizationId -BodyParameter $body
        $response 

    }
}