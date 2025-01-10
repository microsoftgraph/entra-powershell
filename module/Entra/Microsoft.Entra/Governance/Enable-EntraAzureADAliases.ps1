# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Enable-EntraAzureADAliases {
   Set-Alias -Name Remove-AzureADMSRoleAssignment -Value Remove-EntraDirectoryRoleAssignment -Scope Global -Force
   Set-Alias -Name New-AzureADMSRoleDefinition -Value New-EntraDirectoryRoleDefinition -Scope Global -Force
   Set-Alias -Name Get-AzureADMSRoleDefinition -Value Get-EntraDirectoryRoleDefinition -Scope Global -Force
   Set-Alias -Name New-AzureADMSRoleAssignment -Value New-EntraDirectoryRoleAssignment -Scope Global -Force
   Set-Alias -Name Get-AzureADMSRoleAssignment -Value Get-EntraDirectoryRoleAssignment -Scope Global -Force
   Set-Alias -Name Remove-AzureADMSRoleDefinition -Value Remove-EntraDirectoryRoleDefinition -Scope Global -Force
   Set-Alias -Name Set-AzureADMSRoleDefinition -Value Set-EntraDirectoryRoleDefinition -Scope Global -Force
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
   Set-Alias -Name Remove-EntraRoleAssignment -Value Remove-EntraDirectoryRoleAssignment -Scope Global -Force
   Set-Alias -Name Get-EntraRoleAssignment -Value Get-EntraDirectoryRoleAssignment -Scope Global -Force
   Set-Alias -Name New-EntraRoleAssignment -Value New-EntraDirectoryRoleAssignment -Scope Global -Force
   Set-Alias -Name Set-EntraRoleDefinition -Value Set-EntraDirectoryRoleDefinition -Scope Global -Force
   Set-Alias -Name Get-EntraRoleDefinition -Value Get-EntraDirectoryRoleDefinition -Scope Global -Force
   Set-Alias -Name Remove-EntraRoleDefinition -Value Remove-EntraDirectoryRoleDefinition -Scope Global -Force
   Set-Alias -Name New-EntraRoleDefinition -Value New-EntraDirectoryRoleDefinition -Scope Global -Force

}
