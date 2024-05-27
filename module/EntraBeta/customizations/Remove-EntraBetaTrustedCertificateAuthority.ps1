# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADTrustedCertificateAuthority"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        
        $tenantId = (Get-MgContext).TenantId
        $params["Uri"] = "/beta/organization/$tenantId/certificateBasedAuthConfiguration"
        $params["Method"] = "POST"
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
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
        
        $certNotFound = $true
        $modifiedCert = $PSBoundParameters["CertificateAuthorityInformation"]
        $previusCerts = @()        
        Get-EntraBetaTrustedCertificateAuthority | ForEach-Object {
            
            if(($_.TrustedIssuer -eq $modifiedCert.TrustedIssuer) -and ($_.TrustedIssuerSki -eq $modifiedCert.TrustedIssuerSki)){
                $certNotFound = $false
            }
            else{
                $previusCerts += $_
            }            
        }
        if($certNotFound){
            Throw [System.Management.Automation.PSArgumentException] "Provided certificate authority not found on the server. Please make sure you have provided the correct information in trustedIssuer and trustedIssuerSki fields."
        }

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
                
        Invoke-GraphRequest @params -Headers $customHeaders
    } 
'@
}