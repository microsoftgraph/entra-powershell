# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Remove-EntraBetaPrivateAccessApplicationSegment {

	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $True, Position = 1)]
		[string]
		$ObjectID,
		
		[Parameter(Mandatory = $False, Position = 2)]
		[string]
		$ApplicationSegmentId
	)

	PROCESS {  
	
	$customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

	Invoke-GraphRequest -Method DELETE -Headers $customHeaders -OutputType PSObject -Uri "https://graph.microsoft.com/beta/applications/$ObjectID/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments/$ApplicationSegmentId"
	}
}
