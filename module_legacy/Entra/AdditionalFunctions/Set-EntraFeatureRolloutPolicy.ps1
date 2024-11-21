# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Set-EntraFeatureRolloutPolicy {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id,
        [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
        [System.Nullable`1[System.Boolean]] $IsAppliedToOrganization,
        [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
        [System.String] $DisplayName,
        [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
        [System.String] $Description,
        [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
        [System.String] $Feature,
        [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
        [System.Nullable`1[System.Boolean]] $IsEnabled,
        [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
        [System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.MsDirectoryObject]] $AppliesTo
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $body = @{}
        $params["Uri"] = "https://graph.microsoft.com/v1.0/policies/featureRolloutPolicies/$Id"
        $params["Method"] = "PATCH"
    
        if ($null -ne $PSBoundParameters["Description"]) {
            $body["Description"] = $PSBoundParameters["Description"]
        }
        if ($null -ne $PSBoundParameters["IsAppliedToOrganization"]) {
            $body["IsAppliedToOrganization"] = $PSBoundParameters["IsAppliedToOrganization"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $body["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if ($null -ne $PSBoundParameters["Feature"]) {
            $body["Feature"] = $PSBoundParameters["Feature"]
        }
        if ($null -ne $PSBoundParameters["IsEnabled"]) {
            $body["IsEnabled"] = $PSBoundParameters["IsEnabled"]
        }
        if ($null -ne $PSBoundParameters["AppliesTo"]) {
            $body["AppliesTo"] = $PSBoundParameters["AppliesTo"]
        }
    
        $params["Body"] = $body
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Invoke-GraphRequest @params -Headers $customHeaders | ConvertTo-Json | ConvertFrom-Json
        $response 
    }
}