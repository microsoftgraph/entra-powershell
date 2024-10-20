# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function New-EntraBetaPrivateAccessApplication {

	[CmdletBinding(DefaultParameterSetName = 'AllPrivateAccessApps')]
	param (

		[Parameter(Mandatory = $True, Position = 1)]
		[string]
		$ApplicationName,
		
		[Parameter(Mandatory = $False, Position = 2)]
		[string]
		$ConnectorGroupId
	)

    PROCESS {  
    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand


	$bodyJson = @{displayName = $ApplicationName} | ConvertTo-Json -Depth 99 -Compress

	# Instantiate the Private Access app

	try {
		$newApp = Invoke-GraphRequest -Method POST -Headers $customHeaders -Uri https://graph.microsoft.com/beta/applicationTemplates/8adf8e6e-67b2-4cf2-a259-e3dc5476c621/instantiate -Body $bodyJson
	}
	catch {
		Write-Error "Failed to create the Private Access app. Error: $_"
		return
	}

	$bodyJson = @{
		"onPremisesPublishing" = @{
			"applicationType" = "nonwebapp"
			"isAccessibleViaZTNAClient" = $true
		}
	} | ConvertTo-Json -Depth 99 -Compress

	$newAppId = $newApp.application.objectId

	# Set the Private Access app to be accessible via the ZTNA client
	$params = @{
		Method = 'PATCH'
		Uri = "https://graph.microsoft.com/beta/applications/$newAppId/"
		Body = $bodyJson

	}

	Invoke-GraphRequest @params

	$bodyJson = @{
		"@odata.id" = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationproxy/connectorGroups/$ConnectorGroupId"
	} | ConvertTo-Json -Depth 99 -Compress

	# If ConnectorGroupId has been specified, assign the connector group to the app, otherwise the default connector group will be assigned.
	if ($ConnectorGroupId) {
		
		$params = @{
			Method = 'PUT'
			Uri = "https://graph.microsoft.com/beta/applications/$newAppId/connectorGroup/`$ref"
			Body = $bodyJson
		}
			
		Invoke-GraphRequest @params
	}
    
	}
}
