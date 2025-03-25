# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Add-EntraAdministrativeUnitMember {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The ID of a user, group, device, or directory object to add to an administrative unit.")]
        [Alias('RefObjectId')]
        [System.String] $MemberId,

        [Alias('ObjectId')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the administrative unit.")]
        [System.String] $AdministrativeUnitId
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["AdministrativeUnitId"]) {
            $params["AdministrativeUnitId"] = $PSBoundParameters["AdministrativeUnitId"]
            $Uri = "/v1.0/directory/administrativeUnits/$($params.AdministrativeUnitId)/members/" + '$ref'
        }
        if ($null -ne $PSBoundParameters["MemberId"]) {
            $TmpValue = $PSBoundParameters["MemberId"]
            $Value = @{ "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$TmpValue" }
            $params["BodyParameter"] = $Value
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")

        Invoke-GraphRequest -Headers $customHeaders -Uri $Uri -Method "POST" -Body $Value
    }
}

