function New-EntraCustomSecurityAttributeDefinition {
    [CmdletBinding(DefaultParameterSetName = 'NewCustomSecurityAttributeDefinition')]
    param (
    [Parameter()]
    [System.String] $Description,
    [Parameter(Mandatory = $true)]
    [System.String] $Name,
    [Parameter(Mandatory = $true)]
    [System.String] $AttributeSet,
    [Parameter(Mandatory = $true)]
    [System.Nullable`1[System.Boolean]] $UsePreDefinedValuesOnly,
    [Parameter(Mandatory = $true)]
    [System.String] $Type,
    [Parameter(Mandatory = $true)]
    [System.Nullable`1[System.Boolean]] $IsCollection,
    [Parameter(Mandatory = $true)]
    [System.Nullable`1[System.Boolean]] $IsSearchable,
    [Parameter(Mandatory = $true)]
    [System.String] $Status
    )

    PROCESS {    
        $params = @{}
        $body = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $Uri = "https://graph.microsoft.com/v1.0/directory/customSecurityAttributeDefinitions"
        $Method = "POST"
        $keysChanged = @{}

        if($null -ne $PSBoundParameters["AttributeSet"])
        {
            $body["attributeSet"] = $PSBoundParameters["AttributeSet"]  
        }
        if($null -ne $PSBoundParameters["Description"])
        {
            $body["description"] = $PSBoundParameters["Description"]  
        }    
        if($null -ne $PSBoundParameters["IsCollection"])
        {
            $body["isCollection"] = $PSBoundParameters["IsCollection"]  
        }  
        if($null -ne $PSBoundParameters["IsSearchable"])
        {
            $body["isSearchable"] = $PSBoundParameters["IsSearchable"]  
        }  
        if($null -ne $PSBoundParameters["Name"])
        {
            $body["name"] = $PSBoundParameters["Name"]  
        }      
        if($null -ne $PSBoundParameters["Status"])
        {
            $body["status"] = $PSBoundParameters["Status"]
        }
        if($null -ne $PSBoundParameters["Type"])
        {
            $body["type"] = $PSBoundParameters["Type"]
        } 
        if($null -ne $PSBoundParameters["UsePreDefinedValuesOnly"])
        {
            $body["usePreDefinedValuesOnly"] = $PSBoundParameters["UsePreDefinedValuesOnly"]
        }
        

        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }        
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }        
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
    
            $response = Invoke-GraphRequest -Uri $Uri -Method $Method -Body $body -Headers $customHeaders
            $response
    
        }
    }