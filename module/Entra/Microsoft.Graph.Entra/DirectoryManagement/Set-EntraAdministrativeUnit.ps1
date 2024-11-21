# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraAdministrativeUnit {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
    [Alias("ObjectId")]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $AdministrativeUnitId,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Description,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $DisplayName
    )

    PROCESS {    
    $params = @{}
    $body = @{}
    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    
    if($null -ne $PSBoundParameters["AdministrativeUnitId"])
    {
        $params["AdministrativeUnitId"] = $PSBoundParameters["AdministrativeUnitId"]
    }
    if($null -ne $PSBoundParameters["DisplayName"])
    {
        $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        $body["DisplayName"] = $PSBoundParameters["DisplayName"]
    } 
    if($null -ne $PSBoundParameters["Description"])
    {
        $params["Description"] = $PSBoundParameters["Description"]
        $body["Description"] = $PSBoundParameters["Description"]
    }

    $uri = "/v1.0/directory/administrativeUnits/$($params.AdministrativeUnitId)"
    $params["Uri"] = $uri

    $body = $body | ConvertTo-Json

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")

    Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method PATCH -Body $body
    
    }
}# ------------------------------------------------------------------------------

