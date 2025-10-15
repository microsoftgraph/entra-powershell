# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraUserCertificateUserIdsFromCertificate {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $false,
            HelpMessage = "Path to the certificate file. The file can be in .cer or .pem format.")]
        [string]$Path,

        [Parameter(Mandatory = $false,
            HelpMessage = "Certificate object. If provided, the Path parameter is ignored.")]
        [Alias('CertificateObject', 'Cert')]
        [System.Security.Cryptography.X509Certificates.X509Certificate2]$Certificate,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Default',
            HelpMessage = "The certificate mapping type to use. Valid values are: PrincipalName, RFC822Name, IssuerAndSubject, Subject, SKI, SHA1PublicKey, IssuerAndSerialNumber.")]
        [ValidateSet("PrincipalName", "RFC822Name", "IssuerAndSubject", "Subject",
            "SKI", "SHA1PublicKey", "IssuerAndSerialNumber")]
        [string]$CertificateMapping
    )

    function Get-Certificate {
        param (
            [string]$filePath
        )
        if ($filePath.EndsWith(".cer")) {
            return [System.Security.Cryptography.X509Certificates.X509Certificate]::new($filePath)
        }
        elseif ($filePath.EndsWith(".pem")) {
            $pemContent = Get-Content -Path $filePath -Raw
            $pemContent = $pemContent -replace "-----BEGIN CERTIFICATE-----", ""
            $pemContent = $pemContent -replace "-----END CERTIFICATE-----", ""
            $pemContent = $pemContent -replace "(\r\n|\n|\r)", ""
            $pemBytes = [Convert]::FromBase64String($pemContent)
            $certificate = [System.Security.Cryptography.X509Certificates.X509Certificate]::new($pemBytes)

            return $certificate
        }
        else {
            throw "Unsupported certificate format. Please provide a .cer or .pem file."
        }
    }

    function Get-DistinguishedNameAsString {
        param (
            [System.Security.Cryptography.X509Certificates.X500DistinguishedName]$distinguishedName
        )

        $dn = $distinguishedName.Decode([System.Security.Cryptography.X509Certificates.X500DistinguishedNameFlags]::UseNewLines -bor [System.Security.Cryptography.X509Certificates.X500DistinguishedNameFlags]::DoNotUsePlusSign)

        $dn = $dn -replace "(\r\n|\n|\r)", ","
        return $dn.TrimEnd(',')
    }

    function Get-SerialNumberAsLittleEndianHexString {
        param (
            [System.Security.Cryptography.X509Certificates.X509Certificate2]$cert
        )

        $littleEndianSerialNumber = $cert.GetSerialNumber()

        if ($littleEndianSerialNumber.Length -eq 0) {
            return ""
        }

        $hexString = -join ($littleEndianSerialNumber | ForEach-Object { $_.ToString("x2") })
        return $hexString
    }

    function Get-SubjectKeyIdentifier {
        param (
            [System.Security.Cryptography.X509Certificates.X509Certificate2]$cert
        )
        foreach ($extension in $cert.Extensions) {
            if ($extension.Oid.Value -eq "2.5.29.14") {
                $ski = New-Object System.Security.Cryptography.X509Certificates.X509SubjectKeyIdentifierExtension -ArgumentList $extension, $false
                return $ski.SubjectKeyIdentifier
            }
        }

        return ""
    }

    # Function to generate certificate mapping fields
    function Get-CertificateMappingFields {
        param (
            [System.Security.Cryptography.X509Certificates.X509Certificate2]$cert
        )
        $subject = Get-DistinguishedNameAsString -distinguishedName $cert.SubjectName
        $issuer = Get-DistinguishedNameAsString -distinguishedName $cert.IssuerName
        $serialNumber = Get-SerialNumberAsLittleEndianHexString -cert $cert
        $thumbprint = $cert.Thumbprint
        $principalName = $cert.GetNameInfo([System.Security.Cryptography.X509Certificates.X509NameType]::UpnName, $false)
        $emailName = $cert.GetNameInfo([System.Security.Cryptography.X509Certificates.X509NameType]::EmailName, $false)
        $subjectKeyIdentifier = Get-SubjectKeyIdentifier -cert $cert
        $sha1PublicKey = $cert.GetCertHashString()

        return @{
            "SubjectName"          = $subject
            "IssuerName"           = $issuer
            "SerialNumber"         = $serialNumber
            "Thumbprint"           = $thumbprint
            "PrincipalName"        = $principalName
            "EmailName"            = $emailName
            "SubjectKeyIdentifier" = $subjectKeyIdentifier
            "Sha1PublicKey"        = $sha1PublicKey
        }
    }

    function Get-CertificateUserIds {
        param (
            [System.Security.Cryptography.X509Certificates.X509Certificate2]$cert
        )

        $mappingFields = Get-CertificateMappingFields -cert $cert

        $certUserIDs = @{
            "PrincipalName"         = ""
            "RFC822Name"            = ""
            "IssuerAndSubject"      = "" 
            "Subject"               = ""
            "SKI"                   = ""
            "SHA1PublicKey"         = "" 
            "IssuerAndSerialNumber" = ""
        }

        if (-not [string]::IsNullOrWhiteSpace($mappingFields.PrincipalName)) {
            $certUserIDs.PrincipalName = "X509:<PN>$($mappingFields.PrincipalName)"
        }

        if (-not [string]::IsNullOrWhiteSpace($mappingFields.EmailName)) {
            $certUserIDs.RFC822Name = "X509:<RFC822>$($mappingFields.EmailName)"
        }

        if ((-not [string]::IsNullOrWhiteSpace($mappingFields.IssuerName)) -and (-not [string]::IsNullOrWhiteSpace($mappingFields.SubjectName))) {
            $certUserIDs.IssuerAndSubject = "X509:<I>$($mappingFields.IssuerName)<S>$($mappingFields.SubjectName)"
        }

        if (-not [string]::IsNullOrWhiteSpace($mappingFields.SubjectName)) {
            $certUserIDs.Subject = "X509:<S>$($mappingFields.SubjectName)"
        }

        if (-not [string]::IsNullOrWhiteSpace($mappingFields.SubjectKeyIdentifier)) {
            $certUserIDs.SKI = "X509:<SKI>$($mappingFields.SubjectKeyIdentifier)"
        }

        if (-not [string]::IsNullOrWhiteSpace($mappingFields.Sha1PublicKey)) {
            $certUserIDs.SHA1PublicKey = "X509:<SHA1-PUKEY>$($mappingFields.Sha1PublicKey)"
        }

        if ((-not [string]::IsNullOrWhiteSpace($mappingFields.IssuerName)) -and (-not [string]::IsNullOrWhiteSpace($mappingFields.SerialNumber))) {
            $certUserIDs.IssuerAndSerialNumber = "X509:<I>$($mappingFields.IssuerName)<SR>$($mappingFields.SerialNumber)"
        }

        return $certUserIDs
    }

    function Main {
        $cert = $Certificate
        if ($null -eq $cert) {
            $cert = Get-Certificate -filePath $Path
        }

        $mappings = Get-CertificateUserIds -cert $cert

        if ($CertificateMapping -eq "") {
            return $mappings
        }
        else {
            $value = $mappings[$CertificateMapping]
            return "$($value)"
        }
    }

    # Call main function
    return Main
}
