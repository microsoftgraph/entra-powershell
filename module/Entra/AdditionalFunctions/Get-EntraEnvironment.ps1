function Get-EntraEnvironment{
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
          [Parameter(ParameterSetName = "GetQuery", Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Name)
    PROCESS{
        $params = @{}
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }

        if ($null -ne $PSBoundParameters["Name"]) {
            $params["Name"] = $PSBoundParameters["Name"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        Get-MgEnvironment @params 
    }
}