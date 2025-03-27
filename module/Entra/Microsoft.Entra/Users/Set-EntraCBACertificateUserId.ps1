function  Set-EntraCBACertificateUserId {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$UserId,
        [Parameter(Mandatory = $false)]    
        [string]$CertPath,
        [Parameter(Mandatory = $false)]
        [System.Security.Cryptography.X509Certificates.X509Certificate2]$Cert,
        [Parameter(Mandatory = $true)]
        [ValidateSet("PrincipalName", "RFC822Name", "IssuerAndSubject", "Subject", "SKI", "SHA1PublicKey", "IssuerAndSerialNumber")]
        [string]$CertificateMapping
    )

    PROCESS {
        # Ensure all provided parameters are bound correctly
        $params = @{}
        foreach ($paramName in $PSBoundParameters.Keys) {
            $params[$paramName] = $PSBoundParameters[$paramName]
        }
        # Ensure at least one of the parameters about certificate is provided
        if (-not $Cert -and -not $CertPath) {
            throw "You must provide either -Cert or -CertPath."
        }
        . "$PSScriptRoot/../Utilities/Get-EntraUserCertificateUserIdsFromCertificate.ps1"

        if ($Cert -eq $null) {
            # If it's a valid file path, pass it as -Path
            $certUserIdObj = Get-EntraUserCertificateUserIdsFromCertificate -Path $CertPath -CertificateMapping $CertificateMapping
        } elseif ($CertPath -eq $null)
        {
            # If it's already a certificate object, pass it as -CertificateMapping
            $certUserIdObj = Get-EntraUserCertificateUserIdsFromCertificate -Certificate $Cert -CertificateMapping $CertificateMapping
        } else {
            throw "Invalid certificate object or path."
        }


        $userList = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/users?`$select=id"
        $userIdPattern = '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'
              
        
        # Validate user exists
        if (-not ($UserId -match $userIdPattern) -or -not $userList.value.id -contains $UserId) {
            throw "User '$UserId' not found in Entra ID"
        }

        # Prepare the request body
        $body = @{
            authorizationInfo = @{
                certificateUserIds = @($certUserIdObj) 
            }
        } | ConvertTo-Json


        $apiCallUrl = "https://graph.microsoft.com/v1.0/users/$($UserId)?`$select=authorizationInfo"
        $response = Invoke-GraphRequest -Uri $apiCallUrl -Method PATCH -Body $body
        $response
    }
}