---
title: Get-EntraSubscribedSku
description: This article provides details on the Get-EntraSubscribedSku command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraSubscribedSku

schema: 2.0.0
---

# Get-EntraSubscribedSku

## Synopsis

Gets subscribed SKUs to Microsoft services.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraSubscribedSku
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraSubscribedSku
 -ObjectId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraSubscribedSku` cmdlet gets subscribed SKUs to Microsoft services.

## Examples

### Example 1: Get subscribed SKUs

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraSubscribedSku
```

```Output
Id                                                                        AccountId                            AccountName   AppliesTo CapabilityStatus ConsumedUnits SkuId                                SkuPart
                                                                                                                                                                                                           Number
--                                                                        ---------                            -----------   --------- ---------------- ------------- -----                                -------
abcdefgh-1111-2222-bbbb-cccc33333333_dddddddd-4444-5555-eeee-666666666666 00aa00aa-bb11-cc22-dd33-44ee44ee44ee Contoso User      Enabled          20            aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb EMSP...
ijklmnop-1111-2222-bbbb-cccc33333333_dddddddd-4444-5555-eeee-666666666666 11bb11bb-cc22-dd33-ee44-55ff55ff55ff Contoso User      Enabled          20            bbbbbbbb-1111-2222-3333-cccccccccccc ENTE...
qrstuvwx-1111-2222-bbbb-cccc33333333_dddddddd-4444-5555-eeee-666666666666 22cc22cc-dd33-ee44-ff55-66aa66aa66aa Contoso User      Enabled          2             cccccccc-2222-3333-4444-dddddddddddd ENTE...
yzabcdef-1111-2222-bbbb-cccc33333333_dddddddd-4444-5555-eeee-666666666666 33dd33dd-ee44-ff55-aa66-77bb77bb77bb Contoso User      Enabled          3             dddddddd-3333-4444-5555-eeeeeeeeeeee FLOW...
ghijklmn-1111-2222-bbbb-cccc33333333_dddddddd-4444-5555-eeee-666666666666 44ee44ee-ff55-aa66-bb77-88cc88cc88cc Contoso User      Enabled          3             eeeeeeee-4444-5555-6666-ffffffffffff Win1...
opqrstuv-1111-2222-bbbb-cccc33333333_dddddddd-4444-5555-eeee-666666666666 55ff55ff-gg66-bb77-cc88-99dd99dd99dd Contoso User      Enabled          20            ffffffff-7777-8888-9999-gggggggggggg INFO...
```

This example shows how to retrieve subscribed SKUs.

### Example 2: Get subscribed SKUs by ObjectId

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraSubscribedSku -ObjectId 'abcdefgh-1111-2222-bbbb-cccc33333333_dddddddd-4444-5555-eeee-666666666666'
```

```Output
Id                                                                        AccountId                            AccountName   AppliesTo CapabilityStatus ConsumedUnits SkuId                                SkuPart
                                                                                                                                                                                                           Number
--                                                                        ---------                            -----------   --------- ---------------- ------------- -----                                -------
abcdefgh-1111-2222-bbbb-cccc33333333_dddddddd-4444-5555-eeee-666666666666 00aa00aa-bb11-cc22-dd33-44ee44ee44ee Contoso User      Enabled          20            aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb EMSP...
```

This example shows how to retrieve specified subscribed SKUs.

### Example 3: Get a list of users, their assigned licenses, and licensing source

```powershell
Connect-Entra -Scopes 'Organization.Read.All','User.Read.All','Group.Read.All'

# Get all users with specified properties
$Users = Get-EntraUser -All -Property AssignedLicenses, LicenseAssignmentStates, DisplayName, UserPrincipalName, ObjectId

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
            $Group = Get-EntraGroup -ObjectId $AssignedByGroup
            $GroupDisplayNames[$AssignedByGroup] = $Group.DisplayName
        }

        $User | Add-Member -NotePropertyName 'GroupDisplayName' -NotePropertyValue $GroupDisplayNames[$AssignedByGroup]
    } catch {
        $User | Add-Member -NotePropertyName 'GroupDisplayName' -NotePropertyValue 'N/A (Direct Assignment)'
    }

    try {
        # Check if the SKU part number is already in the hashtable
        if (-not $SkuPartNumbers.ContainsKey($SkuId)) {
            $Sku = Get-EntraSubscribedSku | Where-Object { $_.SkuId -eq $SkuId } | Select-Object -ExpandProperty SkuPartNumber
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

Specifies properties to be returned

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
