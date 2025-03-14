# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Enable-EntraAzureADAlias {
   Set-Alias -Name Remove-AzureADApplication -Value Remove-EntraApplication -Scope Global -Force
   Set-Alias -Name New-AzureADMSApplicationKey -Value New-EntraApplicationKey -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSApplicationVerifiedPublisher -Value Remove-EntraApplicationVerifiedPublisher -Scope Global -Force
   Set-Alias -Name Set-AzureADMSApplication -Value Set-EntraApplication -Scope Global -Force
   Set-Alias -Name Remove-AzureADServicePrincipal -Value Remove-EntraServicePrincipal -Scope Global -Force
   Set-Alias -Name Remove-AzureADServiceAppRoleAssignment -Value Remove-EntraServicePrincipalAppRoleAssignment -Scope Global -Force
   Set-Alias -Name Get-AzureADDeletedApplication -Value Get-EntraDeletedApplication -Scope Global -Force
   Set-Alias -Name Get-AzureADServicePrincipalKeyCredential -Value Get-EntraServicePrincipalKeyCredential -Scope Global -Force
   Set-Alias -Name Add-AzureADServicePrincipalOwner -Value Add-EntraServicePrincipalOwner -Scope Global -Force
   Set-Alias -Name Get-AzureADServiceAppRoleAssignedTo -Value Get-EntraServicePrincipalAppRoleAssignedTo -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationKeyCredential -Value Get-EntraApplicationKeyCredential -Scope Global -Force
   Set-Alias -Name New-AzureADApplicationExtensionProperty -Value New-EntraApplicationExtensionProperty -Scope Global -Force
   Set-Alias -Name Remove-AzureADApplicationPasswordCredential -Value Remove-EntraApplicationPasswordCredential -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationExtensionProperty -Value Get-EntraApplicationExtensionProperty -Scope Global -Force
   Set-Alias -Name Get-AzureADServicePrincipal -Value Get-EntraServicePrincipal -Scope Global -Force
   Set-Alias -Name Get-AzureADServicePrincipalMembership -Value Get-EntraServicePrincipalMembership -Scope Global -Force
   Set-Alias -Name Get-AzureADServiceAppRoleAssignment -Value Get-EntraServicePrincipalAppRoleAssignment -Scope Global -Force
   Set-Alias -Name Set-AzureADMSApplicationVerifiedPublisher -Value Set-EntraApplicationVerifiedPublisher -Scope Global -Force
   Set-Alias -Name Remove-AzureADServicePrincipalPasswordCredential -Value Remove-EntraServicePrincipalPasswordCredential -Scope Global -Force
   Set-Alias -Name New-AzureADMSApplicationPassword -Value New-EntraApplicationPassword -Scope Global -Force
   Set-Alias -Name New-AzureADApplicationPasswordCredential -Value New-EntraApplicationPasswordCredential -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSServicePrincipalDelegatedPermissionClassification -Value Remove-EntraServicePrincipalDelegatedPermissionClassification -Scope Global -Force
   Set-Alias -Name Get-AzureADServicePrincipalCreatedObject -Value Get-EntraServicePrincipalCreatedObject -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationOwner -Value Get-EntraApplicationOwner -Scope Global -Force
   Set-Alias -Name Get-AzureADServicePrincipalPasswordCredential -Value Get-EntraServicePrincipalPasswordCredential -Scope Global -Force
   Set-Alias -Name Add-AzureADApplicationOwner -Value Add-EntraApplicationOwner -Scope Global -Force
   Set-Alias -Name New-AzureADServicePrincipalPasswordCredential -Value New-EntraServicePrincipalPasswordCredential -Scope Global -Force
   Set-Alias -Name Get-AzureADServicePrincipalOAuth2PermissionGrant -Value Get-EntraServicePrincipalOAuth2PermissionGrant -Scope Global -Force
   Set-Alias -Name Get-AzureADApplication -Value Get-EntraApplication -Scope Global -Force
   Set-Alias -Name Remove-AzureADServicePrincipalOwner -Value Remove-EntraServicePrincipalOwner -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSApplicationKey -Value Remove-EntraApplicationKey -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSDeletedDirectoryObject -Value Remove-EntraDeletedDirectoryObject -Scope Global -Force
   Set-Alias -Name New-AzureADMSApplication -Value New-EntraApplication -Scope Global -Force
   Set-Alias -Name New-AzureADApplicationKeyCredential -Value New-EntraApplicationKeyCredential -Scope Global -Force
   Set-Alias -Name Get-AzureADServicePrincipalOwner -Value Get-EntraServicePrincipalOwner -Scope Global -Force
   Set-Alias -Name Remove-AzureADApplicationOwner -Value Remove-EntraApplicationOwner -Scope Global -Force
   Set-Alias -Name Set-AzureADServicePrincipal -Value Set-EntraServicePrincipal -Scope Global -Force
   Set-Alias -Name Select-AzureADGroupIdsServicePrincipalIsMemberOf -Value Select-EntraGroupIdsServicePrincipalIsMemberOf -Scope Global -Force
   Set-Alias -Name Remove-AzureADDeletedApplication -Value Remove-EntraDeletedApplication -Scope Global -Force
   Set-Alias -Name New-AzureADServicePrincipal -Value New-EntraServicePrincipal -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationLogo -Value Get-EntraApplicationLogo -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationPasswordCredential -Value Get-EntraApplicationPasswordCredential -Scope Global -Force
   Set-Alias -Name Get-AzureADServicePrincipalOwnedObject -Value Get-EntraServicePrincipalOwnedObject -Scope Global -Force
   Set-Alias -Name Add-AzureADMSServicePrincipalDelegatedPermissionClassification -Value Add-EntraServicePrincipalDelegatedPermissionClassification -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSApplicationPassword -Value Remove-EntraApplicationPassword -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationServiceEndpoint -Value Get-EntraApplicationServiceEndpoint -Scope Global -Force
   Set-Alias -Name Remove-AzureADApplicationKeyCredential -Value Remove-EntraApplicationKeyCredential -Scope Global -Force
   Set-Alias -Name Restore-AzureADDeletedApplication -Value Restore-EntraDeletedApplication -Scope Global -Force
   Set-Alias -Name New-AzureADServiceAppRoleAssignment -Value New-EntraServicePrincipalAppRoleAssignment -Scope Global -Force
   Set-Alias -Name Remove-AzureADServicePrincipalKeyCredential -Value Remove-EntraServicePrincipalKeyCredential -Scope Global -Force
   Set-Alias -Name Get-AzureADMSServicePrincipalDelegatedPermissionClassification -Value Get-EntraServicePrincipalDelegatedPermissionClassification -Scope Global -Force
   Set-Alias -Name Remove-AzureADApplicationExtensionProperty -Value Remove-EntraApplicationExtensionProperty -Scope Global -Force
   Set-Alias -Name Set-AzureADApplicationLogo -Value Set-EntraApplicationLogo -Scope Global -Force
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
   Set-Alias -Name Get-EntraServiceAppRoleAssignedTo -Value Get-EntraServicePrincipalAppRoleAssignedTo -Scope Global -Force
   Set-Alias -Name Remove-EntraServiceAppRoleAssignment -Value Remove-EntraServicePrincipalAppRoleAssignment -Scope Global -Force
   Set-Alias -Name Get-EntraServiceAppRoleAssignment -Value Get-EntraServicePrincipalAppRoleAssignment -Scope Global -Force
   Set-Alias -Name New-EntraServiceAppRoleAssignment -Value New-EntraServicePrincipalAppRoleAssignment -Scope Global -Force

}
