# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraPermissionGrantConditionSet {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $PolicyId,
                
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $ConditionSetType,
        
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias("Select")]
        [System.String[]] $Property
    )

    $params = @{}
    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    if ($PSBoundParameters.ContainsKey("Verbose")) {
        $params["Verbose"] = $PSBoundParameters["Verbose"]
    }
    if ($null -ne $PSBoundParameters["Id"]) {
        $params["PermissionGrantConditionSetId"] = $PSBoundParameters["Id"]
    }
    if ($null -ne $PSBoundParameters["ConditionSetType"]) {
        $conditionalSet = $PSBoundParameters["ConditionSetType"]
    }
    if ($null -ne $PSBoundParameters["PolicyId"]) {
        $params["PermissionGrantPolicyId"] = $PSBoundParameters["PolicyId"]
    }
    if ($PSBoundParameters.ContainsKey("Debug")) {
        $params["Debug"] = $PSBoundParameters["Debug"]
    }       
    if ($null -ne $PSBoundParameters["WarningVariable"]) {
        $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
    }
    if ($null -ne $PSBoundParameters["InformationVariable"]) {
        $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
    }
    if ($null -ne $PSBoundParameters["InformationAction"]) {
        $params["InformationAction"] = $PSBoundParameters["InformationAction"]
    }
    if ($null -ne $PSBoundParameters["OutVariable"]) {
        $params["OutVariable"] = $PSBoundParameters["OutVariable"]
    }
    if ($null -ne $PSBoundParameters["OutBuffer"]) {
        $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
    }
    if ($null -ne $PSBoundParameters["ErrorVariable"]) {
        $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
    }
    if ($null -ne $PSBoundParameters["PipelineVariable"]) {
        $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
    }
    if ($null -ne $PSBoundParameters["ErrorAction"]) {
        $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
    }
    if ($null -ne $PSBoundParameters["WarningAction"]) {
        $params["WarningAction"] = $PSBoundParameters["WarningAction"]
    }
    if ($null -ne $PSBoundParameters["Property"]) {
        $params["Property"] = $PSBoundParameters["Property"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    if ("$conditionalSet" -eq "includes") {
        $response = Get-MgPolicyPermissionGrantPolicyInclude @params -Headers $customHeaders
    }
    elseif ("$conditionalSet" -eq "excludes") {
        $response = Get-MgPolicyPermissionGrantPolicyExclude @params -Headers $customHeaders
    }
    else {
        Write-Error("Message: Resource not found for the segment '$conditionalSet'.")
        return
    }
    
    $response    
}

