# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaPrivateAccessApplication {

    [CmdletBinding(DefaultParameterSetName = 'AllPrivateAccessApps')]
    param (
        [Parameter(Mandatory = $True)]
        [System.String]
        $ApplicationName,
        
        [Parameter(Mandatory = $False)]
        [System.String]
        $ConnectorGroupId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes NetworkAccessPolicy.ReadWrite.All, Application.ReadWrite.All, NetworkAccess.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        try {
            # Create custom headers for the request
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

            $environment = (Get-EntraContext).Environment
            $rootUri = (Get-EntraEnvironment -Name $environment).GraphEndpoint

            # Prepare the request body for instantiating the Private Access app
            $bodyJson = @{ displayName = $ApplicationName } | ConvertTo-Json -Depth 99 -Compress

            # Instantiate the Private Access app
            $newApp = Invoke-GraphRequest -Method POST -Headers $customHeaders -Uri '/beta/applicationTemplates/8adf8e6e-67b2-4cf2-a259-e3dc5476c621/instantiate' -Body $bodyJson

            # Prepare the request body for setting the app to be accessible via the ZTNA client
            $bodyJson = @{
                "onPremisesPublishing" = @{
                    "applicationType"           = "nonwebapp"
                    "isAccessibleViaZTNAClient" = $true
                }
            } | ConvertTo-Json -Depth 99 -Compress

            $newAppId = $newApp.application.objectId

            # Set the Private Access app to be accessible via the ZTNA client
            $params = @{
                Method  = 'PATCH'
                Uri     = "/beta/applications/$newAppId/"
                Headers = $customHeaders
                Body    = $bodyJson
            }

            Invoke-GraphRequest @params

            # If ConnectorGroupId has been specified, assign the connector group to the app
            if ($ConnectorGroupId) {
                $bodyJson = @{
                    "@odata.id" = "$rootUri/beta/onPremisesPublishingProfiles/applicationproxy/connectorGroups/$ConnectorGroupId"
                } | ConvertTo-Json -Depth 99 -Compress
                
                $params = @{
                    Method  = 'PUT'
                    Uri     = "/beta/applications/$newAppId/connectorGroup/`$ref"
                    Headers = $customHeaders
                    Body    = $bodyJson
                }
                    
                Invoke-GraphRequest @params
            }

            Write-Output "Private Access application '$ApplicationName' has been successfully created and configured."
        }
        catch {
            Write-Error "Failed to create the Private Access app. Error: $_"
        }
    }
}
