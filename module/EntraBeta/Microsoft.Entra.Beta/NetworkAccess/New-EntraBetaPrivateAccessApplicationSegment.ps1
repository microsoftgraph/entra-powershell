# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaPrivateAccessApplicationSegment {

    [CmdletBinding(ParameterSetName = 'Default')]
    param (
        [Alias('ObjectId')]
        [Parameter(Mandatory = $True, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String]
        $ApplicationId,
        
        [Parameter(Mandatory = $True)]
        [System.String]
        $DestinationHost,
        
        [Parameter(Mandatory = $False)]
        [System.String[]]
        $Ports,
        
        [Parameter(Mandatory = $False)]
        [ValidateSet("TCP", "UDP")]
        [System.String[]]
        $Protocol,

        [Parameter(Mandatory = $True)]
        [ValidateSet("ipAddress", "dnsSuffix", "ipRangeCidr", "ipRange", "FQDN")]
        [System.String]
        $DestinationType
    )

    PROCESS {
        try {
            # Create custom headers for the request
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
            $portRanges = @()

            # Process port ranges
            foreach ($port in $Ports) {
                if (!$port.Contains("-")) {
                    $portRanges += "$port-$port"
                }
                else {
                    $portRanges += $port
                }
            }

            # Build the request body based on the destination type
            if ($DestinationType -eq "dnsSuffix") {
                $body = @{
                    destinationHost = $DestinationHost.ToLower()
                    destinationType = 'dnsSuffix'
                }
            }
            else {
                switch ($DestinationType) {
                    "ipAddress" { $dstType = 'ip' }
                    "ipRange" { $dstType = 'ipRange' }
                    "fqdn" { $dstType = 'fqdn' }
                    "ipRangeCidr" { $dstType = 'ipRangeCidr' }
                }
                $body = @{
                    destinationHost = $DestinationHost.ToLower()
                    protocol        = $Protocol.ToLower() -join ","
                    ports           = $portRanges
                    destinationType = $dstType
                }
            }

            # Convert the body to JSON
            $bodyJson = $body | ConvertTo-Json -Depth 99 -Compress

            # Define the parameters for the API request
            $params = @{
                Method     = 'POST'
                Uri        = "/beta/applications/$ApplicationId/onPremisesPublishing/segmentsConfiguration/microsoft.graph.ipSegmentConfiguration/applicationSegments/"
                Headers    = $customHeaders
                Body       = $bodyJson
                OutputType = 'PSObject'
            }

            # Invoke the API request
            Invoke-GraphRequest @params
        }
        catch {
            Write-Error "Failed to create the application segment: $_"
        }
    }
}
