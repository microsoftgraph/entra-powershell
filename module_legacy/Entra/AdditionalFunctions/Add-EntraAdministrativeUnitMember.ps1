# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Add-EntraAdministrativeUnitMember {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $RefObjectId,
    [Alias('ObjectId')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $AdministrativeUnitId
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if($null -ne $PSBoundParameters["AdministrativeUnitId"])
        {
            $params["AdministrativeUnitId"] = $PSBoundParameters["AdministrativeUnitId"]
            $Uri = "/v1.0/directory/administrativeUnits/$($params.AdministrativeUnitId)/members/" + '$ref'
        }
        if($null -ne $PSBoundParameters["RefObjectId"])
        {
            $TmpValue = $PSBoundParameters["RefObjectId"]
            $Value = @{ "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$TmpValue"}
            $params["BodyParameter"] = $Value
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")

        Invoke-GraphRequest -Headers $customHeaders -Uri $Uri -Method "POST" -Body $Value
    }
}