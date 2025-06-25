---
author: msewaweru
description: This article provides details on the Set-EntraBetaApplicationProxyApplicationSingleSignOn command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/16/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaApplicationProxyApplicationSingleSignOn
schema: 2.0.0
title: Set-EntraBetaApplicationProxyApplicationSingleSignOn
---

# Set-EntraBetaApplicationProxyApplicationSingleSignOn

## Synopsis

The `Set-EntraBetaApplicationProxyApplicationSingleSignOn` cmdlet allows you to set and modify single sign-on (SSO) settings for an application configured for Application Proxy in Microsoft Entra ID.

## Syntax

```powershell
Set-EntraBetaApplicationProxyApplicationSingleSignOn
 -ApplicationId <String>
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
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso App Proxy'"
$params = @{
    ApplicationId                                   = $application .Id 
    SingleSignOnMode                                = 'OnPremisesKerberos' 
    KerberosInternalApplicationServicePrincipalName = 'https/www.adventure-works.com' 
    KerberosDelegatedLoginIdentity                  = 'OnPremisesUserPrincipalName'
}
Set-EntraBetaApplicationProxyApplicationSingleSignOn @params
```

This example assigns an application to use Kerberos Constrained Delegation, and specify required parameters.

- `-ApplicationId` parameter specifies the application ID.
- `-SingleSignOnMode` parameter specifies the type of SSO.
- `-KerberosInternalApplicationServicePrincipalName` parameter specifies the internal application ServicePrincipalName of the application server.
- `-KerberosDelegatedLoginIdentity` parameter specifies the Connector group ID that assigned to this application.

### Example 2: Remove SSO from an application

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Set-EntraBetaApplicationProxyApplicationSingleSignOn -ApplicationId $application .Id -SingleSignOnMode None'
```

This example demonstrates how to remove SSO from an application.

- `-ApplicationId` parameter specifies the application ID.
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

### -ApplicationId

The unique application ID of the application that needs different SSO settings.
ObjectId can be found using the `Get-EntraBetaApplication` command.
You can also find this in the Microsoft Portal by navigating to Microsoft Entra ID, Enterprise Applications, All Applications, Select your application, go to the properties tab, and use the ObjectId on that page.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

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

## Related links
