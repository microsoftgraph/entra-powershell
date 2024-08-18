# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADTrustedCertificateAuthority"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        
        $tenantId = (Get-MgContext).TenantId
        $params["Uri"] = "/v1.0/organization/$tenantId/certificateBasedAuthConfiguration"
        $params["Method"] = "POST"
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
	    if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        
        $newCert = $PSBoundParameters["CertificateAuthorityInformation"]
        $previusCerts = @()        
        Get-EntraTrustedCertificateAuthority | ForEach-Object {
            $previusCerts += $_
            if(($_.TrustedIssuer -eq $newCert.TrustedIssuer) -and ($_.TrustedIssuerSki -eq $newCert.TrustedIssuerSki)){
                Throw [System.Management.Automation.PSArgumentException] "A certificate already exists on the server with associated trustedIssuer and trustedIssuerSki fields."
            }
        }
        $previusCerts += $newCert

        $body = @{
            certificateAuthorities = @()
        }

        $previusCerts | ForEach-Object {
            $isRoot = $false
            if("RootAuthority" -eq $_.AuthorityType){
                $isRoot = $true
            }
            $cert = @{
                isRootAuthority = $isRoot
                certificateRevocationListUrl = $_.CrlDistributionPoint
                deltaCertificateRevocationListUrl = $_.DeltaCrlDistributionPoint
                certificate = [convert]::tobase64string($_.TrustedCertificate)
            }
            $body.certificateAuthorities += $cert
        }
        $params["Body"] = ConvertTo-Json $body
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
       
        $response = Invoke-GraphRequest @params -Headers $customHeaders

        $customObject = [PSCustomObject]@{
            "@odata.context" = $response["@odata.context"]
            certificateAuthorities = @{
                AuthorityType = if ($response.certificateAuthorities.isRootAuthority) { "RootAuthority" } else { "" }
                CrlDistributionPoint = $response.certificateAuthorities.certificateRevocationListUrl
                DeltaCrlDistributionPoint = $response.certificateAuthorities.deltaCertificateRevocationListUrl
                TrustedCertificate = [Convert]::FromBase64String($response.certificateAuthorities.certificate) 
                TrustedIssuer = $response.certificateAuthorities.issuer
                TrustedIssuerSki = $response.certificateAuthorities.issuerSki
            }
            Id = $response.id
        }
        $customObject
    } 
'@
}