---
title: New-EntraServicePrincipal.
description: This article provides details on the New-EntraServicePrincipal command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraServicePrincipal

## SYNOPSIS
Creates a service principal.

## SYNTAX

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

## DESCRIPTION
Create a new service Principal.

## EXAMPLES

### Example 1: Create a new service principal by DisplayName, AccountEnabled, Tags, and AppRoleAssignmentRequired
```powershell
PS C:\> $MyApp=(Get-EntraApplication -Filter "DisplayName eq 'ToGraph_443DEM'")
PS C:\> New-EntraServicePrincipal -AccountEnabled $true -AppId $MyApp.AppId -AppRoleAssignmentRequired $true -DisplayName $MyApp.DisplayName -Tags {WindowsAzureActiveDirectoryIntegratedApp}
```
```output
DisplayName Id                                   AppId                                SignInAudience                     ServicePrincipalType
----------- --                                   -----                                --------------                     --------------------
test adms   b7a93da9-710d-47ec-9ee9-8213ff0dee4b 9f795b31-e4b5-4ca7-a333-6c0890d62e3c AzureADandPersonalMicrosoftAccount Application
```

This example demonstrates how to create a new service Principal in Microsoft Entra ID.  
First command gets the application and stored in variable.  
Second command creates a new service principal.  
The tag "-Tags {WindowsAzureActiveDirectoryIntegratedApp}" is used to have this service principal show up in the list of Integrated Applications in the Admin Portal.

### Example 2: Create a new service principal by Homepage, logoutUrl, and ReplyUrls 
```powershell
PS C:\> $MyApp=(Get-EntraApplication -Filter "DisplayName eq 'ToGraph_443DEM'")
PS C:\> New-EntraServicePrincipal  -AppId $MyApp.AppId -Homepage 'https://localhost/home' -LogoutUrl 'htpp://localhost/logout' -ReplyUrls 'https://localhost/redirect'  
```
```output
DisplayName Id                                   AppId                                SignInAudience                     ServicePrincipalType
----------- --                                   -----                                --------------                     --------------------
test adms   b7a93da9-710d-47ec-9ee9-8213ff0dee4b 9f795b31-e4b5-4ca7-a333-6c0890d62e3c AzureADandPersonalMicrosoftAccount Application
```

This example demonstrates how to create a new service Principal in Microsoft Entra ID.  
First command gets the application and stored in variable.  
Second command creates a new service principal.

### Example 3: Create a new service principal by KeyCredentials
```powershell
PS C:\> $creds = New-Object Microsoft.Open.AzureAD.Model.KeyCredential
$creds.CustomKeyIdentifier = [System.Text.Encoding]::UTF8.GetBytes("Test")
$startdate = Get-Date -Year 2023 -Month 10 -Day 23
$creds.StartDate = $startdate
$creds.Type = "Symmetric"
$creds.Usage = 'Sign'
$creds.Value = [System.Text.Encoding]::UTF8.GetBytes("123")
$creds.EndDate = Get-Date -Year 2024 -Month 10 -Day 23
PS C:\> $MyApp=(Get-EntraApplication -Filter "DisplayName eq 'ToGraph_443DEM'")
>> New-EntraServicePrincipal -AppId 00e08ac1-6dcb-443d-bf3b-d3723b6bd45f -Homepage 'https://localhost/home' -KeyCredentials $creds
PS C:\> New-EntraServicePrincipal  -AppId $MyApp.AppId  -KeyCredentials $creds
```

```output
DisplayName Id                                   AppId                                SignInAudience                     ServicePrincipalType
----------- --                                   -----                                --------------                     --------------------
test adms2  ee683272-4d02-44b5-83df-ec0527b4e5db 418f12ad-9795-49bb-aebd-a0102973258b AzureADandPersonalMicrosoftAccount Application
```

This example demonstrates how to create a new service Principal in Microsoft Entra ID.  
First command stored the key credentials in a variable.
Second command gets the application and stored in variable.  
Last command creates a new service principal.

### Example 4: Create a new service principal by AlternativeNames, ServicePrincipalType, and ServicePrincipalName
```powershell
PS C:\> $MyApp=(Get-EntraApplication -Filter "DisplayName eq 'ToGraph_443DEM'")
PS C:\> New-EntraServicePrincipal  -AppId $MyApp.AppId -AlternativeNames 'sktest2' -ServicePrincipalType "Application" -ServicePrincipalNames $MyApp.AppId
```
```output
DisplayName Id                                   AppId                                SignInAudience                     ServicePrincipalType
----------- --                                   -----                                --------------                     --------------------
test adms   b7a93da9-710d-47ec-9ee9-8213ff0dee4b 9f795b31-e4b5-4ca7-a333-6c0890d62e3c AzureADandPersonalMicrosoftAccount Application
```

This example demonstrates how to create a new service Principal in Microsoft Entra ID.  
First command gets the application and stored in variable.  
Second command creates a new service principal.

## PARAMETERS

### -AccountEnabled
True if the service principal account is enabled; otherwise, false.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlternativeNames
The alternative names for this service principal

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
Type: String
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
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName
Specifies the display name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Homepage
Specifies the home page.

```yaml
Type: String
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PasswordCredentials
Specifies password credentials.

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

- populate requiredResourceAccess, via "Permissions to other applications" in the Microsoft Entra ID classic portal.  
- specify a resource URI to acquire an access token, which is the URI returned in the claim.

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
The type of the service principal

```yaml
Type: String
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

If you intend for this service principal to show up in the All Applications list in the admin portal, you need to set this value to {WindowsAzureActiveDirectoryIntegratedApp}.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[Remove-EntraServicePrincipal](Remove-EntraServicePrincipal.md)

[Set-EntraServicePrincipal](Set-EntraServicePrincipal.md)

