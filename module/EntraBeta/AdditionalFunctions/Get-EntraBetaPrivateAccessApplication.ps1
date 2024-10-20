# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraBetaPrivateAccessApplication {

	[CmdletBinding(DefaultParameterSetName = 'AllPrivateAccessApps')]
	param (

		[Parameter(Mandatory = $True, Position = 1, ParameterSetName = 'SingleAppID')]
		[string]
		$ObjectID,
		
		[Parameter(Mandatory = $False, ParameterSetName = 'SingleAppName')]
		[string]
		$ApplicationName
	)

    PROCESS {  
    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

	switch ($PSCmdlet.ParameterSetName) {
		"AllPrivateAccessApps" {
			$response = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri 'https://graph.microsoft.com/beta/applications?$count=true&$select=displayName,appId,id,tags,createdDateTime,servicePrincipalType,createdDateTime,servicePrincipalNames&$filter=tags/Any(x: x eq ''PrivateAccessNonWebApplication'') or tags/Any(x: x eq ''NetworkAccessManagedApplication'') or tags/Any(x: x eq ''NetworkAccessQuickAccessApplication'')'
			$response.value
			break
		}			
		"SingleAppID" {
			Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/applications/$ObjectID/?`$select=displayName,appId,id,tags,createdDateTime,servicePrincipalType,createdDateTime,servicePrincipalNames"
			break
		}
		"SingleAppName" {
			$response = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/applications?`$count=true&`$select=displayName,appId,id,tags,createdDateTime,servicePrincipalType,createdDateTime,servicePrincipalNames&`$filter=DisplayName eq '$ApplicationName'"
			$response.value
			break
		}
	}
    }
}
