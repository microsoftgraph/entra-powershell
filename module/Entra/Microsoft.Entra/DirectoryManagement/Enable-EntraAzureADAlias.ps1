# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Enable-EntraAzureADAlias {
   Set-Alias -Name Set-AzureADDomain -Value Set-EntraDomain -Scope Global -Force
   Set-Alias -Name Get-AzureADDirectoryRole -Value Get-EntraDirectoryRole -Scope Global -Force
   Set-Alias -Name Remove-AzureADDirectoryRoleMember -Value Remove-EntraDirectoryRoleMember -Scope Global -Force
   Set-Alias -Name Get-AzureADDomainVerificationDnsRecord -Value Get-EntraDomainVerificationDnsRecord -Scope Global -Force
   Set-Alias -Name Remove-AzureADDeviceRegisteredUser -Value Remove-EntraDeviceRegisteredUser -Scope Global -Force
   Set-Alias -Name Get-AzureADContact -Value Get-EntraContact -Scope Global -Force
   Set-Alias -Name Get-AzureADContactDirectReport -Value Get-EntraContactDirectReport -Scope Global -Force
   Set-Alias -Name Confirm-AzureADDomain -Value Confirm-EntraDomain -Scope Global -Force
   Set-Alias -Name Get-AzureADContactMembership -Value Get-EntraContactMembership -Scope Global -Force
   Set-Alias -Name Get-AzureADDomainNameReference -Value Get-EntraDomainNameReference -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSAdministrativeUnit -Value Remove-EntraAdministrativeUnit -Scope Global -Force
   Set-Alias -Name Remove-AzureADDeviceRegisteredOwner -Value Remove-EntraDeviceRegisteredOwner -Scope Global -Force
   Set-Alias -Name Get-AzureADMSDeletedDirectoryObject -Value Get-EntraDeletedDirectoryObject -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSAdministrativeUnitMember -Value Remove-EntraAdministrativeUnitMember -Scope Global -Force
   Set-Alias -Name Get-AzureADMSRoleDefinition -Value Get-EntraDirectoryRoleDefinition -Scope Global -Force
   Set-Alias -Name Enable-AzureADDirectoryRole -Value Enable-EntraDirectoryRole -Scope Global -Force
   Set-Alias -Name Get-AzureADTenantDetail -Value Get-EntraTenantDetail -Scope Global -Force
   Set-Alias -Name Add-AzureADDirectoryRoleMember -Value Add-EntraDirectoryRoleMember -Scope Global -Force
   Set-Alias -Name Remove-AzureADDevice -Value Remove-EntraDevice -Scope Global -Force
   Set-Alias -Name Get-AzureADDomain -Value Get-EntraDomain -Scope Global -Force
   Set-Alias -Name Get-AzureADMSRoleAssignment -Value Get-EntraDirectoryRoleAssignment -Scope Global -Force
   Set-Alias -Name Get-AzureADSubscribedSku -Value Get-EntraSubscribedSku -Scope Global -Force
   Set-Alias -Name Get-AzureADExtensionProperty -Value Get-EntraExtensionProperty -Scope Global -Force
   Set-Alias -Name Get-AzureADDeviceRegisteredOwner -Value Get-EntraDeviceRegisteredOwner -Scope Global -Force
   Set-Alias -Name Get-AzureADDeviceRegisteredUser -Value Get-EntraDeviceRegisteredUser -Scope Global -Force
   Set-Alias -Name Add-AzureADDeviceRegisteredUser -Value Add-EntraDeviceRegisteredUser -Scope Global -Force
   Set-Alias -Name Add-AzureADDeviceRegisteredOwner -Value Add-EntraDeviceRegisteredOwner -Scope Global -Force
   Set-Alias -Name Get-AzureADContract -Value Get-EntraContract -Scope Global -Force
   Set-Alias -Name Get-AzureADContactManager -Value Get-EntraContactManager -Scope Global -Force
   Set-Alias -Name New-AzureADDomain -Value New-EntraDomain -Scope Global -Force
   Set-Alias -Name Get-AzureADDirectoryRoleMember -Value Get-EntraDirectoryRoleMember -Scope Global -Force
   Set-Alias -Name Get-AzureADDirectoryRoleTemplate -Value Get-EntraDirectoryRoleTemplate -Scope Global -Force
   Set-Alias -Name Set-AzureADDevice -Value Set-EntraDevice -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSScopedRoleMembership -Value Remove-EntraScopedRoleMembership -Scope Global -Force
   Set-Alias -Name Get-AzureADDomainServiceConfigurationRecord -Value Get-EntraDomainServiceConfigurationRecord -Scope Global -Force
   Set-Alias -Name Get-AzureADDevice -Value Get-EntraDevice -Scope Global -Force
   Set-Alias -Name Get-AzureADObjectByObjectId -Value Get-EntraObjectByObjectId -Scope Global -Force
   Set-Alias -Name Remove-AzureADContact -Value Remove-EntraContact -Scope Global -Force
   Set-Alias -Name New-AzureADDevice -Value New-EntraDevice -Scope Global -Force
   Set-Alias -Name Set-AzureADTenantDetail -Value Set-EntraTenantDetail -Scope Global -Force
   Set-Alias -Name Remove-AzureADDomain -Value Remove-EntraDomain -Scope Global -Force
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
   Set-Alias -Name Get-EntraRoleAssignment -Value Get-EntraDirectoryRoleAssignment -Scope Global -Force
   Set-Alias -Name Get-EntraRoleDefinition -Value Get-EntraDirectoryRoleDefinition -Scope Global -Force
   Set-Alias -Name Add-EntraCustomSecurityAttributeDefinitionAllowedValues -Value Add-EntraCustomSecurityAttributeDefinitionAllowedValue -Scope Global -Force

}

