---
author: msewaweru
description: This article provides details on the Get-EntraBetaUserRegisteredDevice command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Users
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Users/Get-EntraBetaUserRegisteredDevice
schema: 2.0.0
title: Get-EntraBetaUserRegisteredDevice
---

# Get-EntraBetaUserRegisteredDevice

## SYNOPSIS

Get devices registered by a user.

## SYNTAX

```powershell
Get-EntraBetaUserRegisteredDevice
 -UserId <String>
 [-Top <Int32>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaUserRegisteredDevice` cmdlet gets devices registered by a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get registered devices

```Powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUserRegisteredDevice -UserId 'SawyerM@contoso.com' | Select-Object Id -ExpandProperty AdditionalProperties
```

```Output
@odata.type                   : #microsoft.graph.device
accountEnabled                : True
approximateLastSignInDateTime : 1/6/2025 9:01:45 AM
createdDateTime               : 11/13/2024 5:11:46 AM
deviceCategory                : Digital IT Owned Device
deviceId                      : 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
deviceOwnership               : Company
deviceVersion                 : 2
displayName                   : Digital-IT-DevBox
enrollmentType                : AzureDomainJoined
isCompliant                   : False
isManaged                     : True
isRooted                      : False
managementType                : MDM
manufacturer                  : Microsoft Corporation
mdmAppId                      : XXXXX-0000-0000-c000-000000000000
model                         : Surface Pro X
operatingSystem               : Windows
operatingSystemVersion        : 10.0.22631.4460
physicalIds                   : {[USER-GID]:xxxxxxxx}
profileType                   : RegisteredDevice
registrationDateTime          : 11/13/2024 5:11:44 AM
systemLabels                  : {}
trustType                     : AzureAd
extensionAttributes           :
alternativeSecurityIds        : {@{type=2; key=WAA1}}
Id                            : 11bb11bb-cc22-dd33-ee44-55ff55ff55ff
```

This command gets the devices that are registered to the specified user.

### Example 2: Get all registered devices

```Powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUserRegisteredDevice -UserId 'SawyerM@contoso.com' -All | Select-Object Id -ExpandProperty AdditionalProperties
```

```Output
@odata.type                   : #microsoft.graph.device
accountEnabled                : True
approximateLastSignInDateTime : 1/6/2025 9:01:45 AM
createdDateTime               : 11/13/2024 5:11:46 AM
deviceCategory                : Digital IT Owned Device
deviceId                      : 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
deviceOwnership               : Company
deviceVersion                 : 2
displayName                   : Digital-IT-DevBox
enrollmentType                : AzureDomainJoined
isCompliant                   : False
isManaged                     : True
isRooted                      : False
managementType                : MDM
manufacturer                  : Microsoft Corporation
mdmAppId                      : XXXXX-0000-0000-c000-000000000000
model                         : Surface Pro X
operatingSystem               : Windows
operatingSystemVersion        : 10.0.22631.4460
physicalIds                   : {[USER-GID]:xxxxxxxx}
profileType                   : RegisteredDevice
registrationDateTime          : 11/13/2024 5:11:44 AM
systemLabels                  : {}
trustType                     : AzureAd
extensionAttributes           :
alternativeSecurityIds        : {@{type=2; key=WAA1}}
Id                            : 11bb11bb-cc22-dd33-ee44-55ff55ff55ff
```

This command gets all the devices that are registered to the specified user.

### Example 3: Get one registered device

```Powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUserRegisteredDevice -UserId 'SawyerM@contoso.com' -Top 1 | Select-Object Id -ExpandProperty AdditionalProperties
```

```Output
@odata.type                   : #microsoft.graph.device
accountEnabled                : True
approximateLastSignInDateTime : 1/6/2025 9:01:45 AM
createdDateTime               : 11/13/2024 5:11:46 AM
deviceCategory                : Digital IT Owned Device
deviceId                      : 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
deviceOwnership               : Company
deviceVersion                 : 2
displayName                   : Digital-IT-DevBox
enrollmentType                : AzureDomainJoined
isCompliant                   : False
isManaged                     : True
isRooted                      : False
managementType                : MDM
manufacturer                  : Microsoft Corporation
mdmAppId                      : XXXXX-0000-0000-c000-000000000000
model                         : Surface Pro X
operatingSystem               : Windows
operatingSystemVersion        : 10.0.22631.4460
physicalIds                   : {[USER-GID]:xxxxxxxx}
profileType                   : RegisteredDevice
registrationDateTime          : 11/13/2024 5:11:44 AM
systemLabels                  : {}
trustType                     : AzureAd
extensionAttributes           :
alternativeSecurityIds        : {@{type=2; key=WAA1}}
Id                            : 11bb11bb-cc22-dd33-ee44-55ff55ff55ff
```

This command gets the top one device that are registered to the specified user. You can use `-Limit` as an alias for `-Top`.

## PARAMETERS

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserId

Specifies the ID of a user (as a User Principal Name or UserId) in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId, UPN, Identity, UserPrincipalName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

Specifies The maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: Limit

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
