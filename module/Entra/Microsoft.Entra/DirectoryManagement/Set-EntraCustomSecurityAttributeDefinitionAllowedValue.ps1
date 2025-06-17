# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraCustomSecurityAttributeDefinitionAllowedValue {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    [Parameter(ParameterSetName = "default")]
    [System.Nullable`1[System.Boolean]] $IsActive,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $CustomSecurityAttributeDefinitionId
    )

    PROCESS {

    $params = @{}
    $body = @{}

    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    $Uri = "/v1.0/directory/customSecurityAttributeDefinitions/$CustomSecurityAttributeDefinitionId/allowedValues/$Id"
    $Method = "PATCH"

    if($null -ne $PSBoundParameters["CustomSecurityAttributeDefinitionId"])
    {
        $params["CustomSecurityAttributeDefinitionId"] = $PSBoundParameters["CustomSecurityAttributeDefinitionId"]
    }
    if($null -ne $PSBoundParameters["Id"])
    {
        $params["Id"] = $PSBoundParameters["Id"]
    }
    if($null -ne $PSBoundParameters["IsActive"])
    {
        $body["IsActive"] = $PSBoundParameters["IsActive"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $response = Invoke-GraphRequest -Uri $Uri -Method $Method -Body $body -Headers $customHeaders
    $response
    }
}# ------------------------------------------------------------------------------

