---
title: Connect-Entra.
description: This article provides details on the Connect-Entra Command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/27/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Connect-Entra

## SYNOPSIS
Connects with an authenticated account to use Microsoft Entra ID cmdlet requests.

## SYNTAX

### UserCredential (Default)
```powershell 
Connect-Entra 
 [-TenantId <String>] 
 [-Credential <PSCredential>]
 [<CommonParameters>]
```

### ServicePrincipalCertificate
```powershell
Connect-Entra 
 -TenantId <String> 
 -ApplicationId <String>
 -CertificateThumbprint <String>
 [<CommonParameters>]
```

### AccessToken
```powershell
Connect-Entra 
 [-TenantId <String>] 
 [-MsAccessToken <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Connect-Entra cmdlet connects an authenticated account to use for Microsoft Entra ID cmdlet requests.

You can use this authenticated account only with Microsoft Entra ID cmdlets.

## EXAMPLES

### Example 1: Connect a session using a variable
```powershell
PS C:\> $Credential = Get-Credential
PS C:\> Connect-Entra -Credential $Credential
```

The first command gets the user credentials, and then stores them in the $Credential variable.

The second command connects the current PowerShell session using the credentials in $Credential.

This account authenticates with Microsoft Entra ID using organizational ID credentials.
You can't use multifactor authentication or Microsoft account credentials to run Microsoft Entra ID cmdlets with this account.

### Example 2: Connect a session using a ApplicationId and CertificateThumbprint
```powershell
PS C:\> Connect-Entra -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -ApplicationId "8886ad7b-1795-4542-9808-c85859d97f23" -CertificateThumbprint F8813914053FBFB5D84F1EFA9EDB3205621C1126
```
This command Connect a session using a ApplicationId and CertificateThumbprint.

## PARAMETERS

### -CertificateThumbprint
Specifies the certificate thumbprint of a digital public key X.509 certificate of a user account that has permission to perform this action.

```yaml
Type: String
Parameter Sets: ServicePrincipalCertificate
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -ApplicationId
Specifies the application ID of the service principal.

```yaml
Type: String
Parameter Sets: ServicePrincipalCertificate
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a PSCredential object.
For more information about the PSCredential object, type Get-Help Get-Credential.

The PSCredential object provides the user ID and password for organizational ID credentials.

```yaml
Type: PSCredential
Parameter Sets: UserCredential
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```



### -MsAccessToken
Specifies a Microsoft Graph access token.

```yaml
Type: String
Parameter Sets: AccessToken
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TenantId
Specifies the ID of a tenant.

If you don't specify this parameter, the account is authenticated with the home tenant.

You must specify the TenantId parameter to authenticate as a service principal or when using Microsoft account.

```yaml
Type: String
Parameter Sets: UserCredential, AccessToken
Aliases: Domain, TenantDomain

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: ServicePrincipalCertificate
Aliases: Domain, TenantDomain

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet isn't run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Disconnect-Entra](Disconnect-Entra.md)

