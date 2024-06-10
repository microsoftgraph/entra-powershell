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
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraDeviceRegisteredUser cmdlet gets a registered user for a Microsoft Entra ID device.

## EXAMPLES

### Example 1: Retrieve the registered user of a device
```powershell
PS C:\> $DevId = (Get-EntraDevice -Top 1).ObjectId
PS C:\> Get-EntraDeviceRegisteredUser -ObjectId $DevId
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {}
preferredLanguage               :
mail                            : Adams@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-4250272103-1192951583-3896461-2714676080
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=Adams@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {}
```

This example demonstrates how to retrieve registered user for a specific Microsoft Entra ID device.  
The first command gets the object ID of a device by using the Get-EntraDevice (./Get-EntraDevice.md) cmdlet, and then stores it in the $DevId variable.  
The second command gets the registered users of the device in $DevId.

### Example 2: Get all registered users of a device
```powershell
PS C:\> Get-EntraDeviceRegisteredUser -ObjectId "74825acb-c984-4b54-ab65-d38347ea5e90" -All 
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {}
preferredLanguage               :
mail                            : Adams@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-4250272103-1192951583-3896461-2714676080
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=Adams@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {}
```

This example demonstrates how to retrieve all registered users for a Microsoft Entra ID device.  
This command gets the all registered users of the specified device.

### Example 3: Get top two registered users of a device
```powershell
PS C:\> Get-EntraDeviceRegisteredUser -ObjectId "74825acb-c984-4b54-ab65-d38347ea5e90" -Top 2
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {}
preferredLanguage               :
mail                            : Adams@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-4250272103-1192951583-3896461-2714676080
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=Adams@M365x99297270.OnMicrosoft.com}}
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
Type: SwitchParameter
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
Type: String
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
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraDeviceRegisteredUser](Add-EntraDeviceRegisteredUser.md)

[Remove-EntraDeviceRegisteredUser](Remove-EntraDeviceRegisteredUser.md)