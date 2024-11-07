# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Enable-EntraAzureADAliases {
   Set-Alias -Name Get-AzureADObjectByObjectId -Value Get-EntraBetaObjectByObjectId -Scope Global -Force
   Set-Alias -Name Add-AzureADGroupOwner -Value Add-EntraBetaGroupOwner -Scope Global -Force
   Set-Alias -Name New-AzureADObjectSetting -Value New-EntraBetaObjectSetting -Scope Global -Force
   Set-Alias -Name Reset-AzureADMSLifeCycleGroup -Value Reset-EntraBetaLifeCycleGroup -Scope Global -Force
   Set-Alias -Name New-AzureADMSGroup -Value New-EntraBetaGroup -Scope Global -Force
   Set-Alias -Name Set-AzureADObjectSetting -Value Set-EntraBetaObjectSetting -Scope Global -Force
   Set-Alias -Name Remove-AzureADGroupMember -Value Remove-EntraBetaGroupMember -Scope Global -Force
   Set-Alias -Name Get-AzureADGroupAppRoleAssignment -Value Get-EntraBetaGroupAppRoleAssignment -Scope Global -Force
   Set-Alias -Name Get-AzureADGroup -Value Get-EntraBetaGroup -Scope Global -Force
   Set-Alias -Name Get-AzureADMSDeletedGroup -Value Get-EntraBetaDeletedGroup -Scope Global -Force
   Set-Alias -Name Get-AzureADMSGroupPermissionGrant -Value Get-EntraBetaGroupPermissionGrant -Scope Global -Force
   Set-Alias -Name Get-AzureADMSLifecyclePolicyGroup -Value Get-EntraBetaLifecyclePolicyGroup -Scope Global -Force
   Set-Alias -Name Remove-AzureADGroupOwner -Value Remove-EntraBetaGroupOwner -Scope Global -Force
   Set-Alias -Name Set-AzureADMSGroup -Value Set-EntraBetaGroup -Scope Global -Force
   Set-Alias -Name Remove-AzureADGroupAppRoleAssignment -Value Remove-EntraBetaGroupAppRoleAssignment -Scope Global -Force
   Set-Alias -Name New-AzureADMSGroupLifecyclePolicy -Value New-EntraBetaGroupLifecyclePolicy -Scope Global -Force
   Set-Alias -Name Select-AzureADGroupIdsGroupIsMemberOf -Value Select-EntraBetaGroupIdsGroupIsMemberOf -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSGroupLifecyclePolicy -Value Remove-EntraBetaGroupLifecyclePolicy -Scope Global -Force
   Set-Alias -Name Add-AzureADGroupMember -Value Add-EntraBetaGroupMember -Scope Global -Force
   Set-Alias -Name Get-AzureADObjectSetting -Value Get-EntraBetaObjectSetting -Scope Global -Force
   Set-Alias -Name Set-AzureADMSGroupLifecyclePolicy -Value Set-EntraBetaGroupLifecyclePolicy -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSLifecyclePolicyGroup -Value Remove-EntraBetaLifecyclePolicyGroup -Scope Global -Force
   Set-Alias -Name Select-AzureADGroupIdsContactIsMemberOf -Value Select-EntraBetaGroupIdsContactIsMemberOf -Scope Global -Force
   Set-Alias -Name Select-AzureADGroupIdsUserIsMemberOf -Value Select-EntraBetaGroupIdsUserIsMemberOf -Scope Global -Force
   Set-Alias -Name Get-AzureADGroupOwner -Value Get-EntraBetaGroupOwner -Scope Global -Force
   Set-Alias -Name Remove-AzureADObjectSetting -Value Remove-EntraBetaObjectSetting -Scope Global -Force
   Set-Alias -Name Get-AzureADMSGroupLifecyclePolicy -Value Get-EntraBetaGroupLifecyclePolicy -Scope Global -Force
   Set-Alias -Name Get-AzureADGroupMember -Value Get-EntraBetaGroupMember -Scope Global -Force
   Set-Alias -Name Remove-AzureADGroup -Value Remove-EntraBetaGroup -Scope Global -Force
   Set-Alias -Name New-AzureADGroupAppRoleAssignment -Value New-EntraBetaGroupAppRoleAssignment -Scope Global -Force
   Set-Alias -Name Add-AzureADMSLifecyclePolicyGroup -Value Add-EntraBetaLifecyclePolicyGroup -Scope Global -Force
   Set-Alias -Name Get-CrossCloudVerificationCode -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-RbacApplicationRoleAssignment -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-RbacApplicationRoleDefinition -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name New-RbacApplicationRoleAssignment -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name New-RbacApplicationRoleDefinition -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Remove-RbacApplicationRoleAssignment -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Remove-RbacApplicationRoleDefinition -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-RbacApplicationRoleDefinition -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationProxyApplicationConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationPasswordCredential -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Remove-AzureADExternalDomainFederation -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name New-AzureADServicePrincipalKeyCredential -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADExtensionProperty -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationServiceEndpoint -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Restore-AzureADMSDeletedDirectoryObject -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADPrivilegedRoleAssignment -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationProxyConnectorMemberOf -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-AzureADApplicationProxyApplication -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name New-AzureADExternalDomainFederation -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Close-AzureADMSPrivilegedRoleAssignmentRequest -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADDeviceConfiguration -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-AzureADApplicationProxyApplicationSingleSignOn -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Open-AzureADMSPrivilegedRoleAssignmentRequest -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADExternalDomainFederation -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-AzureADApplicationProxyApplicationCustomDomainCertificate -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name New-AzureADApplicationProxyConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Add-AzureADMSPrivilegedResource -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationProxyConnectorGroupMembers -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-AzureADApplicationProxyConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Remove-AzureADApplicationProxyConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADCurrentSessionInfo -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-AzureADApplicationProxyApplicationConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Remove-AzureADContactManager -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Remove-AzureADApplicationProxyApplicationConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name New-AzureADApplicationProxyApplication -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Remove-AzureADServicePrincipalKeyCredential -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Set-AzureADApplicationProxyConnector -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADContactThumbnailPhoto -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationProxyConnectorGroup -Value Get-EntraUnsupportedCommand -Scope Global -Force
   Set-Alias -Name Get-AzureADApplicationProxyConnector -Value Get-EntraUnsupportedCommand -Scope Global -Force

}
