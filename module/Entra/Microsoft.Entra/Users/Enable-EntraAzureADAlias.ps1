# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Enable-EntraAzureADAlias {
   Set-Alias -Name Get-AzureADUserOwnedDevice -Value Get-EntraUserOwnedDevice -Scope Global -Force
   Set-Alias -Name Remove-AzureADUserManager -Value Remove-EntraUserManager -Scope Global -Force
   Set-Alias -Name Remove-AzureADUserExtension -Value Remove-EntraUserExtension -Scope Global -Force
   Set-Alias -Name Remove-AzureADUserAppRoleAssignment -Value Remove-EntraUserAppRoleAssignment -Scope Global -Force
   Set-Alias -Name Get-AzureADUserAppRoleAssignment -Value Get-EntraUserAppRoleAssignment -Scope Global -Force
   Set-Alias -Name Set-AzureADUser -Value Set-EntraUser -Scope Global -Force
   Set-Alias -Name Set-AzureADUserPassword -Value Set-EntraUserPassword -Scope Global -Force
   Set-Alias -Name Get-AzureADUser -Value Get-EntraUser -Scope Global -Force
   Set-Alias -Name Get-AzureADUserLicenseDetail -Value Get-EntraUserLicenseDetail -Scope Global -Force
   Set-Alias -Name Set-AzureADUserExtension -Value Set-EntraUserExtension -Scope Global -Force
   Set-Alias -Name New-AzureADUserAppRoleAssignment -Value New-EntraUserAppRoleAssignment -Scope Global -Force
   Set-Alias -Name Set-AzureADUserLicense -Value Set-EntraUserLicense -Scope Global -Force
   Set-Alias -Name Get-AzureADUserThumbnailPhoto -Value Get-EntraUserThumbnailPhoto -Scope Global -Force
   Set-Alias -Name Get-AzureADUserMembership -Value Get-EntraUserMembership -Scope Global -Force
   Set-Alias -Name Set-AzureADUserManager -Value Set-EntraUserManager -Scope Global -Force
   Set-Alias -Name Get-AzureADUserCreatedObject -Value Get-EntraUserCreatedObject -Scope Global -Force
   Set-Alias -Name Get-AzureADUserOwnedObject -Value Get-EntraUserOwnedObject -Scope Global -Force
   Set-Alias -Name Get-AzureADUserManager -Value Get-EntraUserManager -Scope Global -Force
   Set-Alias -Name Get-AzureADUserExtension -Value Get-EntraUserExtension -Scope Global -Force
   Set-Alias -Name Set-AzureADUserThumbnailPhoto -Value Set-EntraUserThumbnailPhoto -Scope Global -Force
   Set-Alias -Name Remove-AzureADUser -Value Remove-EntraUser -Scope Global -Force
   Set-Alias -Name Update-AzureADSignedInUserPassword -Value Update-EntraSignedInUserPassword -Scope Global -Force
   Set-Alias -Name Get-AzureADUserRegisteredDevice -Value Get-EntraUserRegisteredDevice -Scope Global -Force
   Set-Alias -Name Get-AzureADUserOAuth2PermissionGrant -Value Get-EntraUserOAuth2PermissionGrant -Scope Global -Force
   Set-Alias -Name Get-AzureADUserDirectReport -Value Get-EntraUserDirectReport -Scope Global -Force
   Set-Alias -Name New-AzureADUser -Value New-EntraUser -Scope Global -Force
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
