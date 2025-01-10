# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Set-EntraBetaApplicationProxyApplicationConnectorGroup {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias("ObjectId")]
    [System.String] $OnPremisesPublishingProfileId,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ConnectorGroupId
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Method"] = "PUT"
        $body = @{}
        if($null -ne $PSBoundParameters["OnPremisesPublishingProfileId"])
        {
            $params["Uri"] = "https://graph.microsoft.com/beta/applications/$OnPremisesPublishingProfileId/connectorGroup/" + '$ref'
        }
        if($null -ne $PSBoundParameters["ConnectorGroupId"])
        {
            $body = @{
                "@odata.id" = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationproxy/connectorGroups/$ConnectorGroupId"
            }
            $body = $body | ConvertTo-Json
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        Invoke-MgGraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri -Body $body -ContentType "application/json"
    }
}