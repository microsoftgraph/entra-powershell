---
title: Get-EntraDeviceRegisteredUser.
description: This article provides details on the Get-EntraDeviceRegisteredUser command.

ms.service: entra
ms.topic: reference
ms.date: 03/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDeviceRegisteredUser

## SYNOPSIS

Gets a registered user.

## SYNTAX

```powershell
Get-EntraDeviceRegisteredUser 
 -ObjectId <String> 
 [-All <Boolean>]
 [-Top <Int32 >] 
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraDeviceRegisteredUser` cmdlet gets a registered user for a Microsoft Entra ID device.

## EXAMPLES

### Example 1: Retrieve the registered user of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
$DevId = (Get-EntraDevice -Top 1).ObjectId
Get-EntraDeviceRegisteredUser -ObjectId $DevId
```

```Output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {}
preferredLanguage               :
mail                            : admin@contoso.onmicrosoft.com
securityIdentifier              : A-1-22-3-4444444444-5555555555-6666666-7777777777
identities                      : {@{signInType=userPrincipalName; issuer=contoso.onmicrosoft.com; issuerAssignedId=admin@contoso.onmicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {}
```

This example demonstrates how to retrieve registered user for a specific Microsoft Entra ID device.  
The first command gets the object ID of a device by using the Get-EntraDevice (./Get-EntraDevice.md) cmdlet, and then stores it in the `$DevId` variable.  
The second command gets the registered users of the device in `$DevId`.

### Example 2: Get all registered users of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeviceRegisteredUser -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -All 
```

```Output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {}
preferredLanguage               :
mail                            : admin@contoso.onmicrosoft.com
securityIdentifier              : A-1-22-3-4444444444-5555555555-6666666-7777777777
identities                      : {@{signInType=userPrincipalName; issuer=contoso.onmicrosoft.com; issuerAssignedId=admin@contoso.onmicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {}
```

This example demonstrates how to retrieve all registered users for a Microsoft Entra ID device.  
This command gets the all registered users of the specified device.

### Example 3: Get top two registered users of a device

```powershell
Connect-Entra -Scopes 'Device.Read.All'
Get-EntraDeviceRegisteredUser -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 2
```

```Output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {}
preferredLanguage               :
mail                            : admin@contoso.onmicrosoft.com
securityIdentifier              : A-1-22-3-4444444444-5555555555-6666666-7777777777
identities                      : {@{signInType=userPrincipalName; issuer=contoso.onmicrosoft.com; issuerAssignedId=admin@contoso.onmicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {}
```

This example demonstrates how to retrieve top two registered users for a Microsoft Entra ID device.  
This command gets two registered users of the specified device.

## PARAMETERS

### -All

List all pages.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```
### -ObjectId

Specifies an object ID of a device.

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

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32 
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraDeviceRegisteredUser](Add-EntraDeviceRegisteredUser.md)

[Remove-EntraDeviceRegisteredUser](Remove-EntraDeviceRegisteredUser.md)