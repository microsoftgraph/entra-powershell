# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaApplicationProxyConnector {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the on-premises publishing profile object (On-Premises Publishing Profile Object ID).")]
        [ValidateNotNullOrEmpty()]
        [Alias("Id")]
        [System.String] $OnPremisesPublishingProfileId,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the connector group object (Connector Group Object ID).")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ConnectorGroupId
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        
        $rootUri = (Get-EntraEnvironment -Name (Get-EntraContext).Environment).GraphEndpoint

        if (-not $rootUri) {
            $rootUri = "https://graph.microsoft.com"
            Write-Verbose "Using default Graph endpoint: $rootUri"
        }
        $params["Method"] = "POST"
        $body = @{}
        if ($null -ne $PSBoundParameters["OnPremisesPublishingProfileId"]) {
            $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectors/$OnPremisesPublishingProfileId/memberOf/" + '$ref'
        }
        if ($null -ne $PSBoundParameters["ConnectorGroupId"]) {
            $body = @{
                "@odata.id" = "$rootUri/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$ConnectorGroupId"
            }
            $body = $body | ConvertTo-Json
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        Invoke-MgGraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri -Body $body -ContentType "application/json"
    }
}

