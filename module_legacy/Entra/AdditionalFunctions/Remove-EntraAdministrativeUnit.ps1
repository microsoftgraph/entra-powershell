# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Remove-EntraAdministrativeUnit {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
    [Alias("ObjectId")]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $AdministrativeUnitId
    )

    PROCESS {    
    $params = @{}
    $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand    
    if($null -ne $PSBoundParameters["AdministrativeUnitId"])
    {
        $params["AdministrativeUnitId"] = $PSBoundParameters["AdministrativeUnitId"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $uri = "/v1.0/directory/administrativeUnits/$($params.AdministrativeUnitId)"
    $params["Uri"] = $uri

    $response = Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method DELETE    
    $response | ForEach-Object {
        if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
        }
    }
    $response
    }
}