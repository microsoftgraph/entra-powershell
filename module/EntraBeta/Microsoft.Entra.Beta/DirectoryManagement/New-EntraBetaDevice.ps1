# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaDevice {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Nullable`1[System.Int32]] $DeviceObjectVersion,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $DeviceTrustType,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $DeviceMetadata,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Nullable`1[System.Boolean]] $IsManaged,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
    [System.String] $DeviceId,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
    [System.Nullable`1[System.Boolean]] $AccountEnabled,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.List`1[System.String]] $SystemLabels,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Collections.Generic.List`1[System.String]] $DevicePhysicalIds,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
    [System.String] $DeviceOSVersion,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Nullable`1[System.DateTime]] $ApproximateLastLogonTimeStamp,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $ProfileType,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
    [System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AlternativeSecurityId]] $AlternativeSecurityIds,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
    [System.String] $DeviceOSType,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Nullable`1[System.Boolean]] $IsCompliant,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters", Mandatory = $true)]
    [System.String] $DisplayName
    )

    PROCESS {    
    $params = @{}
    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
    if ($null -ne $PSBoundParameters["DeviceObjectVersion"])
    {
        $params["DeviceObjectVersion"] = $PSBoundParameters["DeviceObjectVersion"]
    }
    if ($null -ne $PSBoundParameters["DeviceTrustType"])
    {
        $params["DeviceTrustType"] = $PSBoundParameters["DeviceTrustType"]
    }
    if ($null -ne $PSBoundParameters["InformationAction"])
    {
        $params["InformationAction"] = $PSBoundParameters["InformationAction"]
    }
    if($PSBoundParameters.ContainsKey("Verbose"))
    {
        $params["Verbose"] = $PSBoundParameters["Verbose"]
    }
    if ($null -ne $PSBoundParameters["DeviceMetadata"])
    {
        $params["DeviceMetadata"] = $PSBoundParameters["DeviceMetadata"]
    }
    if ($null -ne $PSBoundParameters["OutBuffer"])
    {
        $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
    }
    if ($null -ne $PSBoundParameters["OutVariable"])
    {
        $params["OutVariable"] = $PSBoundParameters["OutVariable"]
    }
    if ($null -ne $PSBoundParameters["IsManaged"])
    {
        $params["IsManaged"] = $PSBoundParameters["IsManaged"]
    }
    if ($null -ne $PSBoundParameters["DeviceId"])
    {
        $params["DeviceId"] = $PSBoundParameters["DeviceId"]
    }
    if ($null -ne $PSBoundParameters["AccountEnabled"])
    {
        $params["AccountEnabled"] = $PSBoundParameters["AccountEnabled"]
    }
    if ($null -ne $PSBoundParameters["PipelineVariable"])
    {
        $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
    }
    if ($null -ne $PSBoundParameters["SystemLabels"])
    {
        $params["SystemLabels"] = $PSBoundParameters["SystemLabels"]
    }
    if ($null -ne $PSBoundParameters["DevicePhysicalIds"])
    {
        $params["DevicePhysicalIds"] = $PSBoundParameters["DevicePhysicalIds"]
    }
    if ($null -ne $PSBoundParameters["DeviceOSVersion"])
    {
        $params["DeviceOSVersion"] = $PSBoundParameters["DeviceOSVersion"]
    }
    if($PSBoundParameters.ContainsKey("Debug"))
    {
        $params["Debug"] = $PSBoundParameters["Debug"]
    }
    if ($null -ne $PSBoundParameters["ErrorVariable"])
    {
        $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
    }
    if ($null -ne $PSBoundParameters["ApproximateLastLogonTimeStamp"])
    {
        $params["ApproximateLastLogonTimeStamp"] = $PSBoundParameters["ApproximateLastLogonTimeStamp"]
    }
    if ($null -ne $PSBoundParameters["InformationVariable"])
    {
        $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
    }
    if ($null -ne $PSBoundParameters["ProgressAction"])
    {
        $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
    }
    if ($null -ne $PSBoundParameters["ProfileType"])
    {
        $params["ProfileType"] = $PSBoundParameters["ProfileType"]
    }
    if ($null -ne $PSBoundParameters["AlternativeSecurityIds"])
    {
        $params["AlternativeSecurityIds"] = $PSBoundParameters["AlternativeSecurityIds"]
    }
    if ($null -ne $PSBoundParameters["DeviceOSType"])
    {
        $params["DeviceOSType"] = $PSBoundParameters["DeviceOSType"]
    }
    if ($null -ne $PSBoundParameters["IsCompliant"])
    {
        $params["IsCompliant"] = $PSBoundParameters["IsCompliant"]
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
    if ($null -ne $PSBoundParameters["DisplayName"])
    {
        $params["DisplayName"] = $PSBoundParameters["DisplayName"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $response = New-MgBetaDevice @params -Headers $customHeaders
    $response | ForEach-Object {
        if($null -ne $_) {
        Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

        }
    }
    $response
    }
}

