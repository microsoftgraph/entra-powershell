---
title: Set-EntraUserLicense
description: This article provides details on the Set-EntraUserLicense command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraUserLicense

## Synopsis

Adds or removes licenses for a Microsoft online service to the list of assigned licenses for a user.

## Syntax

```powershell
Set-EntraUserLicense 
 -ObjectId <String>
 -AssignedLicenses <AssignedLicenses>
 [<CommonParameters>]
```

## Description

the `Set-EntraUserLicense` Adds or removes licenses for a Microsoft online service to the list of assigned licenses for a user.

For delegated scenarios, the calling user needs at least one of the following Microsoft Entra roles.

- Directory Writers
- License Administrator
- User Administrator

## Examples

### Example 1: Add a license to a user based on a template user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$LicensedUser = Get-EntraUser -ObjectId 'TemplateUser@contoso.com"' 
$User = Get-EntraUser -ObjectId 'SawyerM@contoso.com' 
$License = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense 
$License.SkuId = $LicensedUser.AssignedLicenses.SkuId 
$Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses 
$Licenses.AddLicenses = $License 
Set-EntraUserLicense -ObjectId $User.ObjectId -AssignedLicenses $Licenses
```

This example demonstrates how to assign a license to a user.

### Example 2: Add a license to a user by copying license from another user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$LicensedUser = Get-EntraUser -ObjectId dddddddd-3333-4444-5555-eeeeeeeeeeee
$User = Get-EntraUser -ObjectId aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 
$License1 = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense 
$License1.SkuId = $LicensedUser.AssignedLicenses.SkuId[0] 
$License2 = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
$License2.SkuId = $LicensedUser.AssignedLicenses.SkuId[1]
$addLicensesArray = @()
$addLicensesArray += $License1
$addLicensesArray += $License2
$Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses 
$Licenses.AddLicenses = $addLicensesArray
Set-EntraUserLicense -ObjectId $User.ObjectId -AssignedLicenses $Licenses
```

This example demonstrates how to assign a license to a user by copying license from another user.

## Parameters

### -AssignedLicenses

Specifies a list of licenses to assign or remove.

```yaml
Type: AssignedLicenses
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId

Specifies the ID of a user (as a UPN or ObjectId) in Microsoft Entra ID.

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

[Get-EntraUser](Get-EntraUser.md)
