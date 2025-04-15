# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaApplicationProxyConnector {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias("Id")]
    [System.String] $OnPremisesPublishingProfileId,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ConnectorGroupId
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        
        $rootUri = (Get-EntraEnvironment -Name (Get-EntraContext).Environment).GraphEndpoint
        $params["Method"] = "POST"
        $body = @{}
        if($null -ne $PSBoundParameters["OnPremisesPublishingProfileId"])
        {
            $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectors/$OnPremisesPublishingProfileId/memberOf/" + '$ref'
        }
        if($null -ne $PSBoundParameters["ConnectorGroupId"])
        {
            $body = @{
                "@odata.id" = "$rootUri/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$ConnectorGroupId"
            }
            $body = $body | ConvertTo-Json
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        Invoke-MgGraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri -Body $body -ContentType "application/json"
    }
}

