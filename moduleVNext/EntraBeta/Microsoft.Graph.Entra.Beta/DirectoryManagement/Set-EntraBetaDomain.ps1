# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaDomain {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
                
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Name,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.List`1[System.String]] $SupportedServices,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Nullable`1[System.Boolean]] $IsDefault,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Nullable`1[System.Boolean]] $IsDefaultForCloudRedirections
    )

    PROCESS {    
    $params = @{}
    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
    if ($null -ne $PSBoundParameters["OutVariable"])
    {
        $params["OutVariable"] = $PSBoundParameters["OutVariable"]
    }
    if ($null -ne $PSBoundParameters["WarningVariable"])
    {
        $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
    }
    if ($null -ne $PSBoundParameters["PipelineVariable"])
    {
        $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
    }
    if ($null -ne $PSBoundParameters["Name"])
    {
        $params["DomainId"] = $PSBoundParameters["Name"]
    }
    if ($null -ne $PSBoundParameters["SupportedServices"])
    {
        $params["SupportedServices"] = $PSBoundParameters["SupportedServices"]
    }
    if ($null -ne $PSBoundParameters["ErrorVariable"])
    {
        $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
    }
    if ($null -ne $PSBoundParameters["InformationVariable"])
    {
        $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
    }
    if ($null -ne $PSBoundParameters["IsDefault"])
    {
        $params["IsDefault"] = $PSBoundParameters["IsDefault"]
    }
    if ($null -ne $PSBoundParameters["IsDefaultForCloudRedirections"])
    {
        $params["IsDefaultForCloudRedirections"] = $PSBoundParameters["IsDefaultForCloudRedirections"]
    }
    if($PSBoundParameters.ContainsKey("Debug"))
    {
        $params["Debug"] = $PSBoundParameters["Debug"]
    }
    if ($null -ne $PSBoundParameters["ProgressAction"])
    {
        $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
    }
    if($PSBoundParameters.ContainsKey("Verbose"))
    {
        $params["Verbose"] = $PSBoundParameters["Verbose"]
    }
    if ($null -ne $PSBoundParameters["ErrorAction"])
    {
        $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
    }
    if ($null -ne $PSBoundParameters["InformationAction"])
    {
        $params["InformationAction"] = $PSBoundParameters["InformationAction"]
    }
    if ($null -ne $PSBoundParameters["OutBuffer"])
    {
        $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
    }
    if ($null -ne $PSBoundParameters["WarningAction"])
    {
        $params["WarningAction"] = $PSBoundParameters["WarningAction"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $response = Update-MgBetaDomain @params -Headers $customHeaders
    $response | ForEach-Object {
        if($null -ne $_) {
        Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

        }
    }
    $response
    }
}
