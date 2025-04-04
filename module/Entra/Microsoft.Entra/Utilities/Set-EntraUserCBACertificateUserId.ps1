# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Set-EntraUserCBACertificateUserId {
    [CmdletBinding(DefaultParameterSetName = 'CertPath')]
    [OutputType([Microsoft.Graph.PowerShell.Models.MicrosoftGraphUser])]
    param (
        [Parameter(Mandatory = $true, 
            HelpMessage = 'The unique identifier for the user (User Principal Name or UserId).',
            Position = 0)]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [string]$UserId,

        [Parameter(Mandatory = $true, 
            ParameterSetName = 'CertPath',
            HelpMessage = "Path to the certificate file. The file can be in .cer or .pem format.")]
        [Alias('CertificatePath')]
        [ValidateScript({ Test-Path $_ -PathType Leaf })]
        [string]$CertPath,

        [Parameter(Mandatory = $true, 
            ParameterSetName = 'CertObject',
            HelpMessage = "Certificate object.")]
        [Alias('CertificateObject')]
        [ValidateNotNull()]
        [System.Security.Cryptography.X509Certificates.X509Certificate2]$Cert,

        [Parameter(Mandatory = $true, 
            HelpMessage = "The certificate mapping type to use.")]
        [ValidateSet("PrincipalName", "RFC822Name", "IssuerAndSubject", "Subject", 
            "SKI", "SHA1PublicKey", "IssuerAndSerialNumber")]
        [ValidateNotNullOrEmpty()]
        [string[]]$CertificateMapping
    )

    begin {
        # Import required utility function
        $utilityPath = Join-Path -Path $PSScriptRoot -ChildPath "Utilities\Get-EntraUserCertificateUserIdsFromCertificate.ps1"
        if (Test-Path -Path $utilityPath) {
            . $utilityPath
        }
        else {
            throw "Required utility script not found at $utilityPath"
        }
    }

    process {
        try {
            # Get certificate user IDs based on parameter set
            Write-Verbose "Retrieving certificate user IDs"
            if ($PSCmdlet.ParameterSetName -eq 'CertPath') {
                $allCertUserIds = Get-EntraUserCertificateUserIdsFromCertificate -Path $CertPath
                Write-Verbose "Certificate loaded from path: $CertPath"
            }
            else {
                $allCertUserIds = Get-EntraUserCertificateUserIdsFromCertificate -Certificate $Cert
                Write-Verbose "Certificate loaded from certificate object"
            }

            if (-not $allCertUserIds) {
                throw "Failed to extract certificate user IDs from the certificate"
            }

            # Filter the certificate user IDs based on the requested mappings
            $certUserIdObj = @()
            foreach ($mapping in $CertificateMapping) {
                if ($allCertUserIds.$mapping) {
                    $certUserIdObj += $allCertUserIds.$mapping
                    Write-Verbose "Added mapping type: $mapping"
                }
                else {
                    Write-Warning "Mapping type '$mapping' not found in the certificate"
                }
            }

            if ($certUserIdObj.Count -eq 0) {
                throw "No valid certificate mappings found for the specified mapping types"
            }

            # Check if user exists
            Write-Verbose "Verifying user exists: $UserId"
            
            # Determine if UserId is a UPN or GUID
            if ($UserId -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                $userFilter = "id eq '$UserId'"
            }
            else {
                $userFilter = "userPrincipalName eq '$UserId'"
            }
            
            $userQuery = Invoke-MgGraphRequest -Method GET -Uri "/users?`$filter=$userFilter&`$select=id" -ErrorAction Stop
            
            if (-not $userQuery.value -or $userQuery.value.Count -eq 0) {
                throw "User '$UserId' not found in Entra ID"
            }
            
            $userId = $userQuery.value[0].id
            Write-Verbose "User found with ID: $userId"

            # Prepare the request body
            $body = @{
                authorizationInfo = @{
                    certificateUserIds = $certUserIdObj
                }
            }
            
            $jsonBody = ConvertTo-Json -InputObject $body -Depth 10

            Write-Verbose "Updating certificate user IDs for user: $userId"
            $apiCallUrl = "/users/$userId"
            $response = Invoke-MgGraphRequest -Uri $apiCallUrl -Method PATCH -Body $jsonBody -ErrorAction Stop

            return $response
            
            Write-Verbose "Certificate User IDs successfully updated"
            
            # Return the updated user object
            #Get-MgUser -UserId $userId -Select "id,displayName,userPrincipalName,authorizationInfo"
        }
        catch {
            $errorDetails = $_.Exception.Message
            Write-Error "Failed to update certificate user IDs: $errorDetails"
            throw
        }
    }

    end {
        # Cleanup if needed
    }
}
