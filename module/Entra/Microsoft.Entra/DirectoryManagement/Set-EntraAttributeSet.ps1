# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraAttributeSet {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
    [Parameter(ParameterSetName = "Default")]
    [Alias("Id")]
    [System.String] $AttributeSetId,

    [Parameter(ParameterSetName = "Default")]
    [System.String] $Description,
    
    [Parameter(ParameterSetName = "Default")]
    [System.Nullable`1[System.Int32]] $MaxAttributesPerSet
    )

    PROCESS {    
    $params = @{}
    $body = @{}
    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    $params["Uri"] = "/v1.0/directory/attributeSets/"
    $params["Method"] = "PATCH"    
    if($null -ne $PSBoundParameters["AttributeSetId"])
    {
        $params["Uri"] += $AttributeSetId
    }    
    if($null -ne $PSBoundParameters["Description"])
    {
        $body["description"] = $PSBoundParameters["Description"]
    }    
    if($null -ne $PSBoundParameters["MaxAttributesPerSet"])
    {
        $body["maxAttributesPerSet"] = $PSBoundParameters["MaxAttributesPerSet"]
    }
    $params["Body"] = $body

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $response = Invoke-GraphRequest @params -Headers $customHeaders
    $response
    }
}# ------------------------------------------------------------------------------

