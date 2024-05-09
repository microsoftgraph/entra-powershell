function Get-EntraEnvironment{
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
          [Parameter(ParameterSetName = "GetByName", Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Name)
    PROCESS{
        $params = @{}
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }

        if ($null -ne $PSBoundParameters.ContainsKey("Name") -or $PSBoundParameters["Name"] -ne '') {
            $params["Name"] = $PSBoundParameters["Name"]
        }
        
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
       
        if($null -ne $params["Name"] -or $params["Name"] -ne ''){
          Get-MgEnvironment @params
        }else{
          Get-MgEnvironment
        }     
    }
}
