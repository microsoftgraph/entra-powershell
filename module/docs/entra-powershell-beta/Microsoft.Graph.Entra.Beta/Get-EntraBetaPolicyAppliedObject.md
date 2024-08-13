---
title: Get-EntraBetaPolicyAppliedObject
description: This article provides details on the Get-EntraBetaPolicyAppliedObject command.


ms.topic: reference
ms.date: 08/13/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaPolicyAppliedObject

schema: 2.0.0
---

# Get-EntraBetaPolicyAppliedObject

## Synopsis

Gets a policy-applied object from Microsoft Entra ID.

## Syntax

```powershell
Get-EntraBetaPolicyAppliedObject 
 -Id <String> 
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaPolicyAppliedObject` cmdlet gets a policy-applied object from Microsoft Entra ID.

## Examples

### Example 1: Retrieve a policy-applied object

```powershell
Connect-Entra -Scopes 'Application.Read.All', 'Policy.ReadWrite.ApplicationConfiguration'
Get-EntraBetaPolicyAppliedObject -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```Output
@odata.type                            : #microsoft.graph.servicePrincipal
appId                                  : 00001111-aaaa-2222-bbbb-3333cccc4444
preferredTokenSigningKeyThumbprint     :
deviceManagementAppType                :
appRoles                               : {}
samlSLOBindingType                     : httpRedirect
notificationEmailAddresses             : {}
preferredTokenSigningKeyEndDateTime    :
accountEnabled                         : True
applicationTemplateId                  :
preferredSingleSignOnMode              :
servicePrincipalType                   : Application
servicePrincipalNames                  : {22223333-cccc-4444-dddd-5555eeee6666}
loginUrl                               :
appOwnerOrganizationId                 : 55556666-ffff-7777-aaaa-8888bbbb9999
id                                     : aaaaaaaa-1111-1111-1111-000000000000
tags                                   : {WindowsAzureActiveDirectoryIntegratedApp}
verifiedPublisher                      : @{displayName=; verifiedPublisherId=; addedDateTime=}
signInAudience                         :
homepage                               :
alternativeNames                       : {}
errorUrl                               :
samlMetadataUrl                        :
addIns                                 : {}
disabledByMicrosoftStatus              :
publisherName                          : Microsoft
passwordCredentials                    : {@{secretText=; endDateTime=21/03/2030 14:14:14; customKeyIdentifier=; startDateTime=21/03/2024 12:15:10; hint=nDv;
                                         keyId=7b64a11f-fd72-4338-966e-00dc51a189b6; displayName=}, @{secretText=; endDateTime=21/03/2026 12:12:13; customKeyIdentifier=;
                                         startDateTime=21/03/2024 14:14:14; hint=t9X; keyId=6cf8588c-8281-44ba-b448-06ecd8163736; displayName=}, @{secretText=;
                                         endDateTime=25/03/2030 12:09:49; customKeyIdentifier=; startDateTime=21/03/2024 12:10:13; hint=a5J;
                                         keyId=669a0ac2-7b96-4c1a-bfe2-43b2754ec979; displayName=}, @{secretText=; endDateTime=21/03/2026 12:04:11; customKeyIdentifier=;
                                         startDateTime=25/03/2024 12:04:07; hint=Uy2; keyId=2e22d318-2e38-41c0-8f73-8aac1211c7d3; displayName=}…}
isAuthorizationServiceEnabled          : False
resourceSpecificApplicationPermissions : {}
certification                          :
tokenEncryptionKeyId                   :
samlSingleSignOnSettings               :
appDisplayName                         :
description                            :
keyCredentials                         : {}
deletedDateTime                        :
api                                    : @{resourceSpecificApplicationPermissions=System.Object[]}
publishedPermissionScopes              : {}
appRoleAssignmentRequired              : False
replyUrls                              : {https://login.microsoftonline.com/common/oauth2/nativeclient, https://login.live.com/oauth20_desktop.srf,
                                         msalea708463-7f80-4331-bb6d-bdd6d7128daf://auth, https://localhost}
isManagementRestricted                 :
createdDateTime                        : 07/07/2023 17:03:59
notes                                  :
info                                   :
logoutUrl                              :
appDescription                         :
displayName                            : ProvisioningPowerBi
odata.type                             : #microsoft.graph.servicePrincipal
```

This command retrieve policy-applied object from Microsoft Entra ID.

- `-Id` Parameter specifies ID of the policy for which you want to find the objects.

## Parameters

### -Id

The Id of the policy for which you want to find the objects

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
