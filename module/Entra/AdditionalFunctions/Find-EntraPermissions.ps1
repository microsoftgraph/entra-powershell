function Find-EntraPermissions {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $SearchString,
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Boolean]] $ExactMatch,
    [Parameter(ParameterSetName = "GetQuery", Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $PermissionType,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Boolean]] $All,
     [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Online
    )

    PROCESS {    
        $params = @{}
        if($null -ne $PSBoundParameters["SearchString"])
        {
            $params["SearchString"]=$PSBoundParameters["SearchString"]
        }
        if($null -ne $PSBoundParameters["ExactMatch"])
        {
            $params["ExactMatch"] = $PSBoundParameters["ExactMatch"]
        }
        
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["All"])
        {
            if($PSBoundParameters["All"])
            {
                $params["All"] = $PSBoundParameters["All"]
            }
        }
        if($null -ne $PSBoundParameters["Online"])
        {
            if($PSBoundParameters["Online"])
            {
                $params["Online"] = $PSBoundParameters["Online"]
            }
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["Top"])
        {
            $params["Top"] = $PSBoundParameters["Top"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        Find-MgGraphPermission @params 
        }        
}