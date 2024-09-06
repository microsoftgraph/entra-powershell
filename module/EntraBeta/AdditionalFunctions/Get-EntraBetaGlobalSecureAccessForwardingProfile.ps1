# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraBetaGlobalSecureAccessForwardingProfile {

	param (

		[Parameter(Mandatory = $False, Position = 1)]
		[System.String]
		$ForwardingProfileId

	)

    PROCESS {  
    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

	if($null -ne $PSBoundParameters["ForwardingProfileId"]){

		$response = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/networkAccess/forwardingProfiles/$ForwardingProfileId"
		$response

		}
		else {		
			$response = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/networkAccess/forwardingProfiles/"
			$response.value
		}
	}
            
}			


