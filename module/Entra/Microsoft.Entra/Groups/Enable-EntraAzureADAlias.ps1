# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------
function Enable-EntraAzureADAlias {
   Set-Alias -Name Select-AzureADGroupIdsContactIsMemberOf -Value Select-EntraGroupIdsContactIsMemberOf -Scope Global -Force
   Set-Alias -Name Get-AzureADMSDeletedGroup -Value Get-EntraDeletedGroup -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSLifecyclePolicyGroup -Value Remove-EntraLifecyclePolicyGroup -Scope Global -Force
   Set-Alias -Name Get-AzureADGroup -Value Get-EntraGroup -Scope Global -Force
   Set-Alias -Name New-AzureADMSGroup -Value New-EntraGroup -Scope Global -Force
   Set-Alias -Name Add-AzureADGroupOwner -Value Add-EntraGroupOwner -Scope Global -Force
   Set-Alias -Name Select-AzureADGroupIdsGroupIsMemberOf -Value Select-EntraGroupIdsGroupIsMemberOf -Scope Global -Force
   Set-Alias -Name Get-AzureADGroupOwner -Value Get-EntraGroupOwner -Scope Global -Force
   Set-Alias -Name Remove-AzureADGroup -Value Remove-EntraGroup -Scope Global -Force
   Set-Alias -Name Get-AzureADMSGroupPermissionGrant -Value Get-EntraGroupPermissionGrant -Scope Global -Force
   Set-Alias -Name Get-AzureADMSGroupLifecyclePolicy -Value Get-EntraGroupLifecyclePolicy -Scope Global -Force
   Set-Alias -Name Add-AzureADGroupMember -Value Add-EntraGroupMember -Scope Global -Force
   Set-Alias -Name Remove-AzureADGroupAppRoleAssignment -Value Remove-EntraGroupAppRoleAssignment -Scope Global -Force
   Set-Alias -Name Set-AzureADMSGroup -Value Set-EntraGroup -Scope Global -Force
   Set-Alias -Name New-AzureADGroupAppRoleAssignment -Value New-EntraGroupAppRoleAssignment -Scope Global -Force
   Set-Alias -Name Get-AzureADGroupMember -Value Get-EntraGroupMember -Scope Global -Force
   Set-Alias -Name Select-AzureADGroupIdsUserIsMemberOf -Value Select-EntraGroupIdsUserIsMemberOf -Scope Global -Force
   Set-Alias -Name Reset-AzureADMSLifeCycleGroup -Value Reset-EntraLifeCycleGroup -Scope Global -Force
   Set-Alias -Name Set-AzureADMSGroupLifecyclePolicy -Value Set-EntraGroupLifecyclePolicy -Scope Global -Force
   Set-Alias -Name Remove-AzureADGroupMember -Value Remove-EntraGroupMember -Scope Global -Force
   Set-Alias -Name Remove-AzureADGroupOwner -Value Remove-EntraGroupOwner -Scope Global -Force
   Set-Alias -Name Add-AzureADMSLifecyclePolicyGroup -Value Add-EntraLifecyclePolicyGroup -Scope Global -Force
   Set-Alias -Name Get-AzureADGroupAppRoleAssignment -Value Get-EntraGroupAppRoleAssignment -Scope Global -Force
   Set-Alias -Name Get-AzureADMSLifecyclePolicyGroup -Value Get-EntraLifecyclePolicyGroup -Scope Global -Force
   Set-Alias -Name New-AzureADMSGroupLifecyclePolicy -Value New-EntraGroupLifecyclePolicy -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSGroupLifecyclePolicy -Value Remove-EntraGroupLifecyclePolicy -Scope Global -Force
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
