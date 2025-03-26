function  Set-EntraCBACertificateUserId {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$UserId,
        [Parameter(Mandatory = $true)]    
        [string]$CertPath,
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

        Write-Verbose "Using parameters: $($params | ConvertTo-Json -Depth 2)"

        . "$PSScriptRoot/../Utilities/Get-EntraUserCertificateUserIdsFromCertificate.ps1"
        $certUserIdObj = Get-EntraUserCertificateUserIdsFromCertificate -Path $CertPath -CertificateMapping $CertificateMapping

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