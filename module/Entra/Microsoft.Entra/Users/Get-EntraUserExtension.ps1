# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraUserExtension {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.")]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [System.String] $UserId,
        
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Alias("Select")]
        [System.String[]] $Property
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = "/v1.0/users"
        
        # Required properties
        [string] $extensions = "Id,UserPrincipalName,createdDateTime,employeeId,onPremisesDistinguishedName,userIdentities,"
        
        # Get available extension properties
        $extensionsUri = "/v1.0/directoryObjects/getAvailableExtensionProperties"
        $extensionProperties = Invoke-MgGraphRequest -Uri $extensionsUri -Method POST | ConvertTo-Json | ConvertFrom-Json
        
        # Add extension property names to the extensions string
        if ($null -ne $extensionProperties -and $extensionProperties.value) {
            $extensions += ($extensionProperties.value | Select-Object -ExpandProperty Name) -join ','
        }
        
        # Override extensions with specific properties if provided
        if ($null -ne $PSBoundParameters["Property"]) {
            $extensions = $PSBoundParameters["Property"] -join ','
        }

        $uri = "$baseUri/$UserId" + "?`$select=$extensions"
        $params["Uri"] = $uri
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        # Execute the request and format the output
        $data = Invoke-MgGraphRequest -Uri $($params.Uri) -Method GET -Headers $customHeaders | ConvertTo-Json | ConvertFrom-Json
        
        # Transform the data for output
        if ($null -ne $data) {
            # Convert properties to Name-Value pairs for format-table output
            $result = $data.PSObject.Properties | Where-Object { $_.Name -ne '@odata.context' } | 
            Select-Object @{Name = 'Name'; Expression = { $_.Name } }, @{Name = 'Value'; Expression = { $_.Value } }
            
            # Return formatted result
            return $result | Format-Table Name, Value
        }
        return $null
    }    
}

