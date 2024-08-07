# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function New-EntraBetaPrivateAccessApplicationSegment {

	[CmdletBinding()]
	param (

		[Alias('id')]
		[Parameter(Mandatory = $True, Position = 1, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
		[string]
		$ObjectID,
		
		[Parameter(Mandatory = $True)]
		[string]
		$DestinationHost,
		
		[Parameter(Mandatory = $False)]
		[string[]]
		$Ports,
		
		[Parameter(Mandatory = $False)]
		[ValidateSet("TCP", "UDP")]
		[string[]]
		$Protocol,

		[Parameter(Mandatory = $True)]
		[ValidateSet("ipAddress", "dnsSuffix", "ipRangeCidr","ipRange","FQDN")]
		[string]
		$DestinationType
	)

	PROCESS {  
	
	$customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
	$portRanges = @()

	foreach ($port in $Ports){
		if (!$port.Contains("-")) {
			$portRanges += $port + "-" + $port
		}
		else {
			$portRanges += $port
		}
	}

	if ($DestinationType -eq "dnsSuffix")
	{
		$body = @{
			destinationHost = $DestinationHost.ToLower()
			destinationType = 'dnsSuffix'
			}
	}
	else
	{
			switch ($DestinationType) {
				"ipAddress" { $dstType = 'ip' }
				"ipRange" { $dstType = 'ipRange' }
				"fqdn" { $dstType = 'fqdn' }
				"ipRangeCidr" { $dstType = 'ipRangeCidr' }
			}
		$body = @{
			destinationHost = $DestinationHost.ToLower()
			protocol = $Protocol.ToLower() -join ","
			ports = $portRanges
			destinationType = $dstType
			}
	}

	$bodyJson = $body | ConvertTo-Json -Depth 99 -Compress

	$params = @{
		Method = 'POST'
		Uri = "https://graph.microsoft.com/beta/applications/$ObjectID/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments/"
		Headers = $customHeaders
		Body = $bodyJson
		OutputType = 'PSObject'
	}

	Invoke-GraphRequest @params
}
}
