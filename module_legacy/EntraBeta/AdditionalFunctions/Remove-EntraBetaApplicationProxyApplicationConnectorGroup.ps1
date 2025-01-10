# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Remove-EntraBetaApplicationProxyApplicationConnectorGroup {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias("ObjectId")]
    [System.String] $OnPremisesPublishingProfileId
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Method"] = "DELETE"
        if($null -ne $PSBoundParameters["OnPremisesPublishingProfileId"])
        {
            $params["Uri"] = "https://graph.microsoft.com/beta/applications/$OnPremisesPublishingProfileId/connectorGroup/"+'$ref'
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        Invoke-MgGraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri
    }
}