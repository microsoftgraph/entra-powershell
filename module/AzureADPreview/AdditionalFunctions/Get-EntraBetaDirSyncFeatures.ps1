function Get-EntraBetaDirSyncfeatures {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById",  ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][System.String] $TenantId,
        [Parameter(ParameterSetName = "GetById",  ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][System.String]$Feature
    )
    PROCESS {    
        $params = @{}
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($null -ne $PSBoundParameters["Feature"]) {
            $Feature = $PSBoundParameters["Feature"]
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
        $jsonData = Get-MgBetaDirectoryOnPremiseSynchronization @params | ConvertTo-Json
        $object = ConvertFrom-Json $jsonData
        $table =@()
        foreach ($featureName in $object.Features.PSObject.Properties.Name) {
            $row = New-Object PSObject -Property @{
                'DirSyncFeature' = $featureName -replace "Enabled", ""
                'Enabled' = $object.Features.$featureName
            }
            $table += $row
        }
        if([string]::IsNullOrWhiteSpace($Feature)) {
            $table | Format-Table -AutoSize
        }
        else {
            $table | Where-Object {$_.dirsyncFeature -eq $Feature}
        }
    }
}