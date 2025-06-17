# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraExtensionProperty {
    [CmdletBinding(DefaultParameterSetName = 'Default', SupportsShouldProcess)]
    param (
        [Parameter(ParameterSetName = "Default", HelpMessage = "Specify if synced from on-premises")]
        [System.Nullable[bool]] $IsSyncedFromOnPremises,

        [Parameter(Mandatory = $false, HelpMessage = "Filter by extension property name")]
        [string] $Name
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Directory.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        # Build request URI and body
        $uri = '/v1.0/directoryObjects/microsoft.graph.getAvailableExtensionProperties'
        
        # Add base parameters to body
        $bodyParams = @{
            isSyncedFromOnPremises = $IsSyncedFromOnPremises
        }

        $body = $bodyParams | ConvertTo-Json
        
        # Get custom headers
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

        # Create description for -WhatIf
        $whatIfDescription = "Retrieving extension properties"
        if ($Name) {
            $whatIfDescription += " filtered by name '$Name'"
        }
        if ($PSBoundParameters.ContainsKey('IsSyncedFromOnPremises')) {
            $whatIfDescription += " with IsSyncedFromOnPremises=$IsSyncedFromOnPremises"
        }

        # Add ShouldProcess check
        if ($PSCmdlet.ShouldProcess($uri, $whatIfDescription)) {
            Write-Verbose "Retrieving all extension properties..."
            Write-Debug "Request URI: $uri"
            Write-Debug "Request Body: $body"

            # Call the Graph REST API
            $resp = Invoke-MgGraphRequest -Method POST -Uri $uri -Body $body -Headers $customHeaders
            
            $data = $resp.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json

            if (-not [string]::IsNullOrWhiteSpace($Name)) {
                Write-Verbose "Filtering results for name: $Name"
                $data = $data | Where-Object { $_.name -eq $Name }
            }

            if ($data) {
                $memberList = @()
                foreach ($response in $data) {
                    $memberType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphExtensionProperty
                    if (-not ($response -is [PSObject])) {
                        $response = [PSCustomObject]@{ Value = $response }
                    }
                    $response.PSObject.Properties | ForEach-Object {
                        $propertyName = $_.Name
                        $propertyValue = $_.Value
                        $memberType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                    }
                    $memberList += $memberType
                }
                return $memberList
            }
            else {
                Write-Warning "No extension properties found."
                return $null
            }
        }
    }
}
