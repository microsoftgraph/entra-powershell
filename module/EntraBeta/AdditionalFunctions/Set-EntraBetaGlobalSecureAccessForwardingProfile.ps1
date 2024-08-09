# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Set-EntraBetaGlobalSecureAccessForwardingProfile {

	param (

		[Parameter(Mandatory = $True, Position = 1)]
		[System.String]
		$ForwardingProfileId,
		
		[Parameter(Mandatory = $True, Position = 2)]
		[ValidateSet("Enabled", "Disabled")]
		[System.String]
		$State

	)

    PROCESS {  
    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

	$body = @{state = $State.ToLower()}
	$bodyJson = $body | ConvertTo-Json -Depth 99 -Compress

	Invoke-GraphRequest -Method PATCH -Body $bodyJson -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/networkAccess/forwardingProfiles/$ForwardingProfileId"
	           
	}
}			


