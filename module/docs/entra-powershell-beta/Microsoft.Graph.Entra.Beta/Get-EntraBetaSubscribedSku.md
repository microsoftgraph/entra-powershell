---
title: Get-EntraBetaSubscribedSku
description: This article provides details on the Get-EntraBetaSubscribedSku command.


ms.topic: reference
ms.date: 08/13/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaSubscribedSku

schema: 2.0.0
---

# Get-EntraBetaSubscribedSku

## Synopsis

Gets subscribed SKUs to Microsoft services.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaSubscribedSku
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaSubscribedSku
 -ObjectId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaSubscribedSku` cmdlet gets subscribed SKUs to Microsoft services.

## Examples

### Example 1: Get subscribed SKUs

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraBetaSubscribedSku
```

```Output
Id                                                                        AccountId                            AccountName   AppliesTo CapabilityStatus ConsumedUnits SkuId                                SkuPartNumber
--                                                                        ---------                            -----------   --------- ---------------- ------------- -----                                -------
aaaa0000-bb11-2222-33cc-444444dddddd 0000aaaa-11bb-cccc-dd22-eeeeee333333 M365x99297270 User      Enabled          20            aaaaaaaa-0b0b-1c1c-2d2d-333333333333 EMSP...
bbbb1111-cc22-3333-44dd-555555eeeeee 1111bbbb-22cc-dddd-ee33-ffffff444444 M365x99297270 User      Enabled          20            bbbbbbbb-1c1c-2d2d-3e3e-444444444444 ENTE...
cccc2222-dd33-4444-55ee-666666ffffff 2222cccc-33dd-eeee-ff44-aaaaaa555555 M365x99297270 User      Enabled          2             cccccccc-2d2d-3e3e-4f4f-555555555555 ENTE...
```

This example demonstrates how to retrieve subscribed SKUs to Microsoft services.

### Example 2: Get subscribed SKUs by ObjectId

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraBetaSubscribedSku -ObjectId 'aaaaaaaa-0b0b-1c1c-2d2d-333333333333'
```

```Output
Id                                                                        AccountId                            AccountName   AppliesTo CapabilityStatus ConsumedUnits SkuId                                SkuPartNumber
--                                                                        ---------                            -----------   --------- ---------------- ------------- -----                                -------
aaaa0000-bb11-2222-33cc-444444dddddd 0000aaaa-11bb-cccc-dd22-eeeeee333333 M365x99297270 User      Enabled          20            aaaaaaaa-0b0b-1c1c-2d2d-333333333333 EMSP...
```

This example demonstrates how to retrieve specified subscribed SKUs to Microsoft services.

- `-ObjectId` parameter specifies the ID of the SKU (Stock Keeping Unit).

### Example 3: Retrieve all users assigned a specific license

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
$sku = Get-EntraBetaSubscribedSku | Where-Object { $_.SkuPartNumber -eq 'DEVELOPERPACK_E5' }
$skuId = $sku.SkuId
$usersWithDeveloperPackE5 = Get-EntraBetaUser -All | Where-Object {
    $_.AssignedLicenses -and ($_.AssignedLicenses.SkuId -contains $skuId)
}
$usersWithDeveloperPackE5 | Select-Object Id, DisplayName, UserPrincipalName, AccountEnabled, UserType | Format-Table -AutoSize
```

```Output
Id                                   DisplayName     UserPrincipalName               AccountEnabled   UserType
--                                   -----------     -----------------               --------------   --------
cccccccc-2222-3333-4444-dddddddddddd  Angel Brown    AngelB@contoso.com              True             Member
dddddddd-3333-4444-5555-eeeeeeeeeeee  Avery Smith    AveryS@contoso.com              True             Member
eeeeeeee-4444-5555-6666-ffffffffffff  Sawyer Miller  SawyerM@contoso.com             True             Member
```

This example demonstrates how to retrieve all users assigned a specific license.

### Example 4: Get a list of users, their assigned licenses, and licensing source

```powershell
Connect-Entra -Scopes 'Organization.Read.All','User.Read.All','Group.Read.All'

# Get all users with specified properties
$Users = Get-EntraBetaUser -All -Property AssignedLicenses, LicenseAssignmentStates, DisplayName, UserPrincipalName, ObjectId

$SelectedUsers = $Users | Select-Object ObjectId, UserPrincipalName, DisplayName, AssignedLicenses -ExpandProperty LicenseAssignmentStates

# Group Name lookup
$GroupDisplayNames = @{}

# Sku Part Number lookup
$SkuPartNumbers = @{}

# Populate the hashtable with group display names and SKU part numbers
foreach ($User in $SelectedUsers) {
    $AssignedByGroup = $User.AssignedByGroup
    $SkuId = $User.SkuId

    try {
        # Check if the group display name is already in the hashtable
        if (-not $GroupDisplayNames.ContainsKey($AssignedByGroup)) {
            $Group = Get-EntraBetaGroup -ObjectId $AssignedByGroup
            $GroupDisplayNames[$AssignedByGroup] = $Group.DisplayName
        }

        $User | Add-Member -NotePropertyName 'GroupDisplayName' -NotePropertyValue $GroupDisplayNames[$AssignedByGroup]
    } catch {
        $User | Add-Member -NotePropertyName 'GroupDisplayName' -NotePropertyValue 'N/A (Direct Assignment)'
    }

    try {
        # Check if the SKU part number is already in the hashtable
        if (-not $SkuPartNumbers.ContainsKey($SkuId)) {
            $Sku = Get-EntraBetaSubscribedSku | Where-Object { $_.SkuId -eq $SkuId } | Select-Object -ExpandProperty SkuPartNumber
            $SkuPartNumbers[$SkuId] = $Sku
        }

        $User | Add-Member -NotePropertyName 'SkuPartNumber' -NotePropertyValue $SkuPartNumbers[$SkuId]
    } catch {
        $User | Add-Member -NotePropertyName 'SkuPartNumber' -NotePropertyValue 'N/A'
    }
}

$SelectedUsers | Format-Table UserPrincipalName, DisplayName, AssignedByGroup, GroupDisplayName, SkuId, SkuPartNumber, State, Error -AutoSize
```

```Output
userPrincipalName       displayName       assignedByGroup                      GroupDisplayName    skuId                                SkuPartNumber  state  error
-----------------       -----------       ---------------                      ----------------    -----                                -------------  -----  -----
averyh@contoso.com      Avery Howard      cccccccc-2222-3333-4444-dddddddddddd Contoso Team        abcdefgh-1111-2222-bbbb-cccc33333333 ENTERPRISEPACK Active None
devont@contoso.com      Devon Torres      ffffffff-5555-6666-7777-aaaaaaaaaaaa Retail              abcdefgh-1111-2222-bbbb-cccc33333333 ENTERPRISEPACK Active None
```

This example shows a list of users, their licenses, and the source of the license such as directly assigned or group assigned.

## Parameters

### -ObjectId

The object ID of the SKU (Stock Keeping Unit).

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
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
