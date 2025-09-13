# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaCustomSecurityAttributeDefinition {
    [CmdletBinding(DefaultParameterSetName = 'CreateCustomSecurityAttributeDefinition')]
    param (
                
    [Parameter(ParameterSetName = "CreateCustomSecurityAttributeDefinition", Mandatory = $true)]
    [System.Nullable`1[System.Boolean]] $UsePreDefinedValuesOnly,
                
    [Parameter(ParameterSetName = "CreateCustomSecurityAttributeDefinition", Mandatory = $true)]
    [System.String] $Name,
                
    [Parameter(ParameterSetName = "CreateCustomSecurityAttributeDefinition", Mandatory = $true)]
    [System.String] $Status,
                
    [Parameter(ParameterSetName = "CreateCustomSecurityAttributeDefinition")]
    [System.String] $Description,
                
    [Parameter(ParameterSetName = "CreateCustomSecurityAttributeDefinition", Mandatory = $true)]
    [System.Nullable`1[System.Boolean]] $IsCollection,
                
    [Parameter(ParameterSetName = "CreateCustomSecurityAttributeDefinition", Mandatory = $true)]
    [System.Nullable`1[System.Boolean]] $IsSearchable,
                
    [Parameter(ParameterSetName = "CreateCustomSecurityAttributeDefinition", Mandatory = $true)]
    [System.String] $AttributeSet,
                
    [Parameter(ParameterSetName = "CreateCustomSecurityAttributeDefinition", Mandatory = $true)]
    [System.String] $Type
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes CustomSecAttributeDefinition.Read.All, CustomSecAttributeDefinition.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
    $params = @{}
    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
    if ($null -ne $PSBoundParameters["UsePreDefinedValuesOnly"])
    {
        $params["UsePreDefinedValuesOnly"] = $PSBoundParameters["UsePreDefinedValuesOnly"]
    }
    if ($null -ne $PSBoundParameters["ProgressAction"])
    {
        $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
    }
    if ($null -ne $PSBoundParameters["Name"])
    {
        $params["Name"] = $PSBoundParameters["Name"]
    }
    if ($null -ne $PSBoundParameters["Status"])
    {
        $params["Status"] = $PSBoundParameters["Status"]
    }
    if($PSBoundParameters.ContainsKey("Debug"))
    {
        $params["Debug"] = $PSBoundParameters["Debug"]
    }
    if ($null -ne $PSBoundParameters["OutBuffer"])
    {
        $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
    }
    if ($null -ne $PSBoundParameters["ErrorAction"])
    {
        $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
    }
    if ($null -ne $PSBoundParameters["WarningVariable"])
    {
        $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
    }
    if ($null -ne $PSBoundParameters["WarningAction"])
    {
        $params["WarningAction"] = $PSBoundParameters["WarningAction"]
    }
    if ($null -ne $PSBoundParameters["Description"])
    {
        $params["Description"] = $PSBoundParameters["Description"]
    }
    if ($null -ne $PSBoundParameters["OutVariable"])
    {
        $params["OutVariable"] = $PSBoundParameters["OutVariable"]
    }
    if ($null -ne $PSBoundParameters["IsCollection"])
    {
        $params["IsCollection"] = $PSBoundParameters["IsCollection"]
    }
    if($PSBoundParameters.ContainsKey("Verbose"))
    {
        $params["Verbose"] = $PSBoundParameters["Verbose"]
    }
    if ($null -ne $PSBoundParameters["IsSearchable"])
    {
        $params["IsSearchable"] = $PSBoundParameters["IsSearchable"]
    }
    if ($null -ne $PSBoundParameters["AttributeSet"])
    {
        $params["AttributeSet"] = $PSBoundParameters["AttributeSet"]
    }
    if ($null -ne $PSBoundParameters["Type"])
    {
        $params["Type"] = $PSBoundParameters["Type"]
    }
    if ($null -ne $PSBoundParameters["PipelineVariable"])
    {
        $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
    }
    if ($null -ne $PSBoundParameters["InformationVariable"])
    {
        $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
    }
    if ($null -ne $PSBoundParameters["InformationAction"])
    {
        $params["InformationAction"] = $PSBoundParameters["InformationAction"]
    }
    if ($null -ne $PSBoundParameters["ErrorVariable"])
    {
        $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $response = New-MgBetaDirectoryCustomSecurityAttributeDefinition @params -Headers $customHeaders
    $response | ForEach-Object {
        if($null -ne $_) {
        Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

        }
    }
    $response
    }
}

