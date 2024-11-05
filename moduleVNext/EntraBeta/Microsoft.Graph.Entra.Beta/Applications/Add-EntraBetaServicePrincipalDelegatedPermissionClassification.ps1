# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Add-EntraBetaServicePrincipalDelegatedPermissionClassification {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
                
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ServicePrincipalId,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
    [System.String] $PermissionName,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
    [System.Nullable`1[Microsoft.Open.MSGraph.Model.DelegatedPermissionClassification+ClassificationEnum]] $Classification,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
    [System.String] $PermissionId
    )

    PROCESS {    
    $params = @{}
    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
    if ($null -ne $PSBoundParameters["OutBuffer"])
    {
        $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
    }
    if ($null -ne $PSBoundParameters["InformationAction"])
    {
        $params["InformationAction"] = $PSBoundParameters["InformationAction"]
    }
    if ($null -ne $PSBoundParameters["ServicePrincipalId"])
    {
        $params["ServicePrincipalId"] = $PSBoundParameters["ServicePrincipalId"]
    }
    if ($null -ne $PSBoundParameters["PipelineVariable"])
    {
        $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
    }
    if($PSBoundParameters.ContainsKey("Debug"))
    {
        $params["Debug"] = $PSBoundParameters["Debug"]
    }
    if ($null -ne $PSBoundParameters["InformationVariable"])
    {
        $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
    }
    if ($null -ne $PSBoundParameters["ErrorVariable"])
    {
        $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
    }
    if ($null -ne $PSBoundParameters["PermissionName"])
    {
        $params["PermissionName"] = $PSBoundParameters["PermissionName"]
    }
    if ($null -ne $PSBoundParameters["Classification"])
    {
        $params["Classification"] = $PSBoundParameters["Classification"]
    }
    if ($null -ne $PSBoundParameters["OutVariable"])
    {
        $params["OutVariable"] = $PSBoundParameters["OutVariable"]
    }
    if ($null -ne $PSBoundParameters["WarningAction"])
    {
        $params["WarningAction"] = $PSBoundParameters["WarningAction"]
    }
    if ($null -ne $PSBoundParameters["ErrorAction"])
    {
        $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
    }
    if($PSBoundParameters.ContainsKey("Verbose"))
    {
        $params["Verbose"] = $PSBoundParameters["Verbose"]
    }
    if ($null -ne $PSBoundParameters["PermissionId"])
    {
        $params["PermissionId"] = $PSBoundParameters["PermissionId"]
    }
    if ($null -ne $PSBoundParameters["ProgressAction"])
    {
        $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
    }
    if ($null -ne $PSBoundParameters["WarningVariable"])
    {
        $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $response = New-MgBetaServicePrincipalDelegatedPermissionClassification @params -Headers $customHeaders
    $response | ForEach-Object {
        if($null -ne $_) {
        Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

        }
    }
    $response
    }
}

