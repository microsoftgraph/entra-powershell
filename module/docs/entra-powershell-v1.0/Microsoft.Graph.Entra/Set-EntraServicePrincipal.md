---
title: Set-EntraServicePrincipal.
description: This article provides details on the Set-EntraServicePrincipal command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/21/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraServicePrincipal

## SYNOPSIS
Updates a service principal.

## SYNTAX

```
Set-EntraServicePrincipal
 -ObjectId <String>
 [-KeyCredentials <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.KeyCredential]>]
 [-Homepage <String>] 
 [-AppId <String>] 
 [-LogoutUrl <String>] 
 [-ServicePrincipalType <String>]
 [-SamlMetadataUrl <String>] 
 [-AlternativeNames <System.Collections.Generic.List`1[System.String]>]
 [-PasswordCredentials <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.PasswordCredential]>]
 [-ErrorUrl <String>] 
 [-PublisherName <String>] 
 [-Tags <System.Collections.Generic.List`1[System.String]>] 
 [-AccountEnabled <String>]
 [-ServicePrincipalNames <System.Collections.Generic.List`1[System.String]>]
 [-AppRoleAssignmentRequired <Boolean>] 
 [-DisplayName <String>]
 [-ReplyUrls <System.Collections.Generic.List`1[System.String]>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraServicePrincipal cmdlet updates a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Disable the account of a service principal
```powershell
PS C:\> Set-EntraServicePrincipal -ObjectId "2e0d8ca7-57d1-4a87-9c2a-b3638a4cadbf" -AccountEnabled $False
```

This example demonstrates how to update AccountEnabled of a service principal in Microsoft Entra ID.  
This command disables the account of the specified service principal.

### Example 2: Update AppId and Homepage of a service principal
```powershell
PS C:\> Set-EntraServicePrincipal -ObjectId "2e0d8ca7-57d1-4a87-9c2a-b3638a4cadbf" -AppId "ea4752b5-03f5-474d-87a8-1c6c88612a19" -Homepage "https://*.e-days.com/SSO/SAML2/SP/AssertionConsumer.aspx?metadata=e-days|ISV9.2|primary|z"
```

This example demonstrates how to update AppId and Homepage of a service principal in Microsoft Entra ID.

### Example 3: Update AlternativeNames and DisplayName of a service principal
```powershell
PS C:\> Set-EntraServicePrincipal -ObjectId "2e0d8ca7-57d1-4a87-9c2a-b3638a4cadbf" -AlternativeNames "skdemotest1" -DisplayName "NewName"
```

This example demonstrates how to update AlternativeNames and DisplayName of a service principal in Microsoft Entra ID. 

### Example 4: Update LogoutUrl and ReplyUrls of a service principal
```powershell
PS C:\> Set-EntraServicePrincipal -ObjectId "2e0d8ca7-57d1-4a87-9c2a-b3638a4cadbf" -LogoutUrl "https://securescore.office.com/SignOut" -ReplyUrls 'https://admin.microsoft1.com"
```

This example demonstrates how to update LogoutUrl and ReplyUrls of a service principal in Microsoft Entra ID. 

### Example 5: Update ServicePrincipalType and AppRoleAssignmentRequired of a service principal
```powershell
PS C:\> Set-EntraServicePrincipal -ObjectId "2e0d8ca7-57d1-4a87-9c2a-b3638a4cadbf" -ServicePrincipalType "Application" -AppRoleAssignmentRequired $True
```

This example demonstrates how to update ServicePrincipalType and AppRoleAssignmentRequired of a service principal in Microsoft Entra ID. 

### Example 6: Update KeyCredentials of a service principal
```powershell
PS C:\> $creds = New-Object Microsoft.Open.AzureAD.Model.KeyCredential
 $creds.CustomKeyIdentifier = [System.Text.Encoding]::UTF8.GetBytes("Test")
 $startdate = Get-Date -Year 2024 -Month 10 -Day 10
 $creds.StartDate = $startdate
 $creds.Type = "Symmetric"
 $creds.Usage = 'Sign'
 $creds.Value = [System.Text.Encoding]::UTF8.GetBytes("A")
 $creds.EndDate = Get-Date -Year 2025 -Month 12 -Day 20 
 Set-EntraServicePrincipal -ObjectId "2e0d8ca7-57d1-4a87-9c2a-b3638a4cadbf" -KeyCredentials $creds
```

This example demonstrates how to update KeyCredentials of a service principal in Microsoft Entra ID.   
First command stored the key credentials in a variable.  
Second command updates KeyCredentials of a service principal.

## PARAMETERS

### -AccountEnabled
Indicates whether the account is enabled.

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
Specifies the application ID.

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

### -ErrorUrl
Specifies the error URL.

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
Specifies the home page or landing page of the application.

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
Specifies key credentials.

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

### -ObjectId
Species the ID of a service principal in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

### -PublisherName
Specifies the publisher name.

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

### -ReplyUrls
The URLs that user tokens are sent to for sign in with the associated application, or the redirect Uniform Resource Identifiers that OAuth 2.0 authorization codes and access tokens are sent to for the associated application.

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

### -SamlMetadataUrl
The URL for the Security Assertion Markup Language (SAML) metadata.

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

### -ServicePrincipalNames
Specifies service principal names.

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
The service principal type.

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
Specifies an array of tags.
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[New-EntraServicePrincipal](New-EntraServicePrincipal.md)

[Remove-EntraServicePrincipal](Remove-EntraServicePrincipal.md)

