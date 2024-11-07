---
title: Set-EntraBetaApplicationProxyApplicationSingleSignOn
description: This article provides details on the Set-EntraBetaApplicationProxyApplicationSingleSignOn command.


ms.topic: reference
ms.date: 07/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaApplicationProxyApplicationSingleSignOn

schema: 2.0.0
---

# Set-EntraBetaApplicationProxyApplicationSingleSignOn

## Synopsis

The `Set-EntraBetaApplicationProxyApplicationSingleSignOn` cmdlet allows you to set and modify single sign-on (SSO) settings for an application configured for Application Proxy in Microsoft Entra ID.

## Syntax

```powershell
Set-EntraBetaApplicationProxyApplicationSingleSignOn
 -ObjectId <String>
 -SingleSignOnMode <SingleSignOnModeEnum>
 [-KerberosInternalApplicationServicePrincipalName <String>]
 [-KerberosDelegatedLoginIdentity <KerberosSignOnMappingAttributeTypeEnum>]
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaApplicationProxyApplicationSingleSignOn` cmdlet allows you to set and modify single sign-on (SSO) settings for an application configured for Application Proxy in Microsoft Entra ID.
This is limited to setting No SSO, Kerberos Constrained Delegation (for applications using Integrated Windows Authentication), and Header-based SSO.

## Examples

### Example 1:  Assign an application to use Kerberos Constrained Delegation, and specify required parameters

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    ObjectId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' 
    SingleSignOnMode = 'OnPremisesKerberos' 
    KerberosInternalApplicationServicePrincipalName = 'https/www.adventure-works.com' 
    KerberosDelegatedLoginIdentity = 'OnPremisesUserPrincipalName'
}
Set-EntraBetaApplicationProxyApplicationSingleSignOn @params
```

This example assigns an application to use Kerberos Constrained Delegation, and specify required parameters.

- `-ObjectId` parameter specifies the application ID.
- `-SingleSignOnMode` parameter specifies the type of SSO.
- `-KerberosInternalApplicationServicePrincipalName` parameter specifies the internal application ServicePrincipalName of the application server.
- `-KerberosDelegatedLoginIdentity` parameter specifies the Connector group ID that assigned to this application.

### Example 2: Remove SSO from an application

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    ObjectId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' 
    SingleSignOnMode = 'None' 
}
Set-EntraBetaApplicationProxyApplicationSingleSignOn @params
```

This example demonstrates how to remove SSO from an application.

- `-ObjectId` parameter specifies the application ID.
- `-SingleSignOnMode` parameter specifies the type of SSO.

## Parameters

### -KerberosDelegatedLoginIdentity

The identity that the Connector can use on behalf of your users to authenticate.

```yaml
Type: KerberosSignOnMappingAttributeTypeEnum
Parameter Sets: (All)
Aliases:
Accepted values: UserPrincipalName, OnPremisesUserPrincipalName, UserPrincipalUsername, OnPremisesUserPrincipalUsername, OnPremisesSAMAccountName

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -KerberosInternalApplicationServicePrincipalName

The internal application SPN of the application server.
This ServicePrincipalName (SPN) needs to be in the list of services to which the Connector can present delegated credentials.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId

The unique application ID of the application that needs different SSO settings.
ObjectId can be found using the `Get-EntraBetaApplication` command.
You can also find this in the Microsoft Portal by navigating to Microsoft Entra ID, Enterprise Applications, All Applications, Select your application, go to the properties tab, and use the ObjectId on that page.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SingleSignOnMode

Choose the type of SSO you would like the application to use.
Only three SSO settings are supported in PowerShell, for more options, please use the Microsoft Portal.

```yaml
Type: SingleSignOnModeEnum
Parameter Sets: (All)
Aliases:
Accepted values: None, OnPremisesKerberos, HeaderBased

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

System.Nullable\`1\[\[Microsoft.Open.MSGraph.Model.OnPremisesPublishingSingleSignOnObject+SingleSignOnModeEnum, Microsoft.Open.MS.GraphV10.Client, Version=2.0.0.0, Culture=neutral, PublicKeyToken=null\]\] System.Nullable\`1\[\[Microsoft.Open.MSGraph.Model.OnPremisesPublishingKerberosSignOnSettingsObject+KerberosSignOnMappingAttributeTypeEnum, Microsoft.Open.MS.GraphV10.Client, Version=2.0.0.0, Culture=neutral, PublicKeyToken=null\]\]

## Outputs

### System.Object

## Notes

## Related Links
