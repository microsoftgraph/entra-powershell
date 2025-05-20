---
title: New-EntraServicePrincipal
description: This article provides details on the New-EntraServicePrincipal command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraServicePrincipal

schema: 2.0.0
---

# New-EntraServicePrincipal

## Synopsis

Creates a service principal.

## Syntax

```powershell
New-EntraServicePrincipal
 -AppId <String>
 [-KeyCredentials <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.KeyCredential]>]
 [-Homepage <String>]
 [-LogoutUrl <String>]
 [-ServicePrincipalType <String>]
 [-AlternativeNames <System.Collections.Generic.List`1[System.String]>]
 [-PasswordCredentials <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PasswordCredential]>]
 [-Tags <System.Collections.Generic.List`1[System.String]>]
 [-AccountEnabled <String>]
 [-ServicePrincipalNames <System.Collections.Generic.List`1[System.String]>]
 [-AppRoleAssignmentRequired <Boolean>]
 [-DisplayName <String>]
 [-ReplyUrls <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## Description

Create a new service Principal.

For multitenant apps, the calling user must also be in at least one of the following Microsoft Entra roles:

- Application Administrator
- Cloud Application Administrator

For single-tenant apps where the calling user is a non-admin user but is the owner of the backing application, the user must have the Application Developer role.

## Examples

### Example 1: Create a new service principal using DisplayName, AccountEnabled, Tags, and AppRoleAssignmentRequired

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$MyApp=(Get-EntraApplication -Filter "DisplayName eq 'Demo App'")
$params = @{
    AccountEnabled = $true 
    AppId = $MyApp.AppId 
    AppRoleAssignmentRequired = $true 
    DisplayName = $MyApp.DisplayName 
    Tags = {WindowsAzureActiveDirectoryIntegratedApp}
}
New-EntraServicePrincipal @params
```

```Output
DisplayName Id                                   AppId                                SignInAudience ServicePrincipalType
----------- --                                   -----                                -------------- --------------------
Demo App    bbbbbbbb-1111-2222-3333-cccccccccccc 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg   Application
```

This example demonstrates how to create a new service Principal in Microsoft Entra ID. You can use the command `Get-EntraApplication` to get application app Id.

The tag `-Tags {WindowsAzureActiveDirectoryIntegratedApp}` is used to have this service principal show up in the list of Integrated Applications in the Admin Portal.

- `-AccountEnabled` parameter specifies true if the service principal account is enabled, otherwise false.
- `-AppId` parameter specifies the unique identifier for the associated application (its appId property).
- `-DisplayName` parameter specifies the service principal display name.
- `-AppRoleAssignmentRequired` parameter indicates whether an application role assignment is required.

### Example 2: Create a new service principal using Homepage, logoutUrl, and ReplyUrls

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$MyApp=(Get-EntraApplication -Filter "DisplayName eq 'Demo App'")
$params = @{
    AppId = $MyApp.AppId 
    Homepage = 'https://localhost/home' 
    LogoutUrl = 'htpp://localhost/logout' 
    ReplyUrls = 'https://localhost/redirect'
}
New-EntraServicePrincipal @params  
```

```Output
DisplayName Id                                   AppId                                SignInAudience ServicePrincipalType
----------- --                                   -----                                -------------- --------------------
Demo App    bbbbbbbb-1111-2222-3333-cccccccccccc 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg   Application
```

This example demonstrates how to create a new service Principal in Microsoft Entra ID. You can use the command `Get-EntraApplication` to get application app Id.

- `-AppId` parameter specifies the unique identifier for the associated application (its appId property).
- `-Homepage` parameter specifies the home page or landing page of the application.
- `-LogoutUrl` parameter specifies the logout URL.
- `-ReplyUrls` parameter specifies the URLs that user tokens are sent to for sign in with the associated application.

### Example 3: Create a new service principal by KeyCredentials

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$creds = New-Object Microsoft.Open.AzureAD.Model.KeyCredential
$creds.CustomKeyIdentifier = [System.Text.Encoding]::UTF8.GetBytes('Test')
$startdate = Get-Date -Year 2023 -Month 10 -Day 23
$creds.StartDate = $startdate
$creds.Type = 'Symmetric'
$creds.Usage = 'Sign'
$creds.Value = [System.Text.Encoding]::UTF8.GetBytes('strong-cred-value')
$creds.EndDate = Get-Date -Year 2024 -Month 10 -Day 23
$MyApp=(Get-EntraApplication -Filter "DisplayName eq 'Demo App'")
$params = @{
    AppId = $MyApp.AppId  
    KeyCredentials = $creds
}
New-EntraServicePrincipal @params
```

```Output
DisplayName Id                                   AppId                                SignInAudience ServicePrincipalType
----------- --                                   -----                                -------------- --------------------
Demo App    bbbbbbbb-1111-2222-3333-cccccccccccc 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg   Application
```

This example demonstrates how to create a new service Principal in Microsoft Entra ID. You can use the command `Get-EntraApplication` to get application app Id.

- `-AppId` parameter specifies the unique identifier for the associated application (its appId property).
- `-KeyCredentials` parameter specifies the collection of key credentials associated with the service principal.

### Example 4: Create a new service principal by AlternativeNames, ServicePrincipalType, and ServicePrincipalName

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$MyApp=(Get-EntraApplication -Filter "DisplayName eq 'Demo App'")
$params = @{
    AppId = $MyApp.AppId 
    AlternativeNames = 'sktest2' 
    ServicePrincipalType = 'Application' 
    ServicePrincipalNames = $MyApp.AppId
}
New-EntraServicePrincipal @params
```

```Output
DisplayName Id                                   AppId                                SignInAudience                     ServicePrincipalType
----------- --                                   -----                                --------------                     --------------------
Demo App   bbbbbbbb-1111-2222-3333-cccccccccccc 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADandPersonalMicrosoftAccount Application
```

This example demonstrates how to create a new service Principal in Microsoft Entra ID. You can use the command `Get-EntraApplication` to get application app Id.

- `-AppId` parameter specifies the unique identifier for the associated application (its appId property).
- `-AlternativeNames` parameter specifies the alternative names for this service principal.
- `-ServicePrincipalType` parameter specifies the type of the service principal.
- `-ServicePrincipalNames` parameter specifies an array of service principal names.

## Parameters

### -AccountEnabled

True if the service principal account is enabled; otherwise, false.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlternativeNames

The alternative names for this service principal.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppId

The unique identifier for the associated application (its appId property).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AppRoleAssignmentRequired

Indicates whether an application role assignment is required.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName

Specifies the service principal display name.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Homepage

Home page or landing page of the application.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeyCredentials

The collection of key credentials associated with the service principal.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.KeyCredential]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogoutUrl

Specifies the logout URL.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordCredentials

The collection of password credentials associated with the application.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PasswordCredential]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReplyUrls

The URLs that user tokens are sent to for sign in with the associated application, or the redirect URIs that OAuth 2.0 authorization codes and access tokens are sent to for the associated application.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServicePrincipalNames

Specifies an array of service principal names.
Based on the identifierURIs collection, plus the application's appId property, these URIs are used to reference an application's service principal.
A client uses ServicePrincipalNames to:

- populate requiredResourceAccess, via "Permissions to other applications" in the Azure classic portal.
- Specify a resource URI to acquire an access token, which is the URI returned in the claim.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServicePrincipalType

The type of the service principal.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags

Tags linked to this service principal.

Note that if you intend for this service principal to show up in the All Applications list in the admin portal, you need to set this value to {WindowsAzureActiveDirectoryIntegratedApp}.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[Remove-EntraServicePrincipal](Remove-EntraServicePrincipal.md)

[Set-EntraServicePrincipal](Set-EntraServicePrincipal.md)
