# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Enable-EntraAzureADAlias  {
   Set-Alias -Name New-AzureADMSInvitation -Value New-EntraInvitation -Scope Global -Force
   Set-Alias -Name New-AzureADTrustedCertificateAuthority -Value New-EntraTrustedCertificateAuthority -Scope Global -Force
   Set-Alias -Name Get-AzureADMSIdentityProvider -Value Get-EntraIdentityProvider -Scope Global -Force
   Set-Alias -Name New-AzureADMSNamedLocationPolicy -Value New-EntraNamedLocationPolicy -Scope Global -Force
   Set-Alias -Name Get-AzureADMSConditionalAccessPolicy -Value Get-EntraConditionalAccessPolicy -Scope Global -Force
   Set-Alias -Name Get-AzureADMSNamedLocationPolicy -Value Get-EntraNamedLocationPolicy -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSConditionalAccessPolicy -Value Remove-EntraConditionalAccessPolicy -Scope Global -Force
   Set-Alias -Name Remove-AzureADOAuth2PermissionGrant -Value Remove-EntraOAuth2PermissionGrant -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSIdentityProvider -Value Remove-EntraIdentityProvider -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSNamedLocationPolicy -Value Remove-EntraNamedLocationPolicy -Scope Global -Force
   Set-Alias -Name Get-AzureADTrustedCertificateAuthority -Value Get-EntraTrustedCertificateAuthority -Scope Global -Force
   Set-Alias -Name Set-AzureADMSIdentityProvider -Value Set-EntraIdentityProvider -Scope Global -Force
   Set-Alias -Name Set-AzureADTrustedCertificateAuthority -Value Set-EntraTrustedCertificateAuthority -Scope Global -Force
   Set-Alias -Name Set-AzureADMSAuthorizationPolicy -Value Set-EntraAuthorizationPolicy -Scope Global -Force
   Set-Alias -Name New-AzureADMSPermissionGrantPolicy -Value New-EntraPermissionGrantPolicy -Scope Global -Force
   Set-Alias -Name New-AzureADMSIdentityProvider -Value New-EntraIdentityProvider -Scope Global -Force
   Set-Alias -Name New-AzureADMSPermissionGrantConditionSet -Value New-EntraPermissionGrantConditionSet -Scope Global -Force
   Set-Alias -Name New-AzureADMSConditionalAccessPolicy -Value New-EntraConditionalAccessPolicy -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSPermissionGrantConditionSet -Value Remove-EntraPermissionGrantConditionSet -Scope Global -Force
   Set-Alias -Name Set-AzureADMSConditionalAccessPolicy -Value Set-EntraConditionalAccessPolicy -Scope Global -Force
   Set-Alias -Name Remove-AzureADTrustedCertificateAuthority -Value Remove-EntraTrustedCertificateAuthority -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSPermissionGrantPolicy -Value Remove-EntraPermissionGrantPolicy -Scope Global -Force
   Set-Alias -Name Set-AzureADMSPermissionGrantPolicy -Value Set-EntraPermissionGrantPolicy -Scope Global -Force
   Set-Alias -Name Set-AzureADMSPermissionGrantConditionSet -Value Set-EntraPermissionGrantConditionSet -Scope Global -Force
   Set-Alias -Name Set-AzureADMSNamedLocationPolicy -Value Set-EntraNamedLocationPolicy -Scope Global -Force
   Set-Alias -Name Get-AzureADMSPermissionGrantPolicy -Value Get-EntraPermissionGrantPolicy -Scope Global -Force
   Set-Alias -Name Get-AzureADMSPermissionGrantConditionSet -Value Get-EntraPermissionGrantConditionSet -Scope Global -Force
   Set-Alias -Name Get-AzureADOAuth2PermissionGrant -Value Get-EntraOAuth2PermissionGrant -Scope Global -Force
   Set-Alias -Name Get-CrossCloudVerificationCode -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationProxyApplication -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name New-AzureADApplicationProxyConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-AzureADApplicationProxyApplicationCustomDomainCertificate -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADMSAdministrativeUnit -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationProxyApplicationConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Remove-AzureADApplicationProxyApplicationConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Remove-AzureADContactManager -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Remove-AzureADApplicationProxyApplication -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-AzureADMSAdministrativeUnit -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Restore-AzureADMSDeletedDirectoryObject -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name New-AzureADApplicationProxyApplication -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADMSAuthorizationPolicy -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name New-AzureADServicePrincipalKeyCredential -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationProxyConnectorGroupMember -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationProxyConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationProxyConnectorMemberOf -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-AzureADApplicationProxyConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADMSScopedRoleMembership -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADDeviceConfiguration -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name New-AzureADMSAdministrativeUnit -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Add-AzureADMSAdministrativeUnitMember -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationProxyConnector -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Remove-AzureADApplicationProxyConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-AzureADApplicationProxyApplicationConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADContactThumbnailPhoto -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADCurrentSessionInfo -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-AzureADApplicationProxyApplication -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Add-AzureADMSScopedRoleMembership -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-AzureADApplicationProxyApplicationSingleSignOn -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADMSAdministrativeUnitMember -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-AzureADApplicationProxyConnector -Value Get-EntraUnsupportedCommand -Scope Global -Force

}
