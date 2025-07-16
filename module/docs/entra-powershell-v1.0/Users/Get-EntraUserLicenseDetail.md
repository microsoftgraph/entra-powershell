---
author: msewaweru
description: This article provides details on the Get-EntraUserLicenseDetail command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraUserLicenseDetail
schema: 2.0.0
title: Get-EntraUserLicenseDetail
---

# Get-EntraUserLicenseDetail

## SYNOPSIS

Retrieves license details for a user.

## SYNTAX

```powershell
Get-EntraUserLicenseDetail
 -UserId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet retrieves a user's license details.

In delegated scenarios with work or school accounts, the signed-in user needs a supported Microsoft Entra role or a custom role with the `microsoft.directory/users/licenseDetails/read` permission. The following least privileged roles support this operation:

- Guest Inviter  
- Directory Readers  
- Directory Writers  
- License Administrator  
- User Administrator

In delegated scenarios with work or school accounts, the signed-in user needs a supported Microsoft Entra role or a custom role with the `microsoft.directory/users/licenseDetails/read` permission. The following least privileged roles support this operation:

- Guest Inviter  
- Directory Readers  
- Directory Writers  
- License Administrator  
- User Administrator

## EXAMPLES

### Example 1: Retrieve user license details

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserLicenseDetail -UserId 'SawyerM@contoso.com'
```

```Output
Id                                          SkuId                                SkuPartNumber
--                                          -----                                -------------
X8Wu1RItQkSNL8zKldQ5DiH6ThjDmF1OlavQcFOpbmc aaaaaaaa-0b0b-1c1c-2d2d-333333333333 INFORMATION_PROTECTION_COMPLIANCE
X8Wu1RItQkSNL8zKldQ5Dk8SXrDMx6BFpqqM94yUaWg bbbbbbbb-1c1c-2d2d-3e3e-444444444444 EMSPREMIUM
X8Wu1RItQkSNL8zKldQ5DmAn38eBLPdOtXhbU5K1cd8 cccccccc-2d2d-3e3e-4f4f-555555555555 ENTERPRISEPREMIUM
```

This example demonstrates how to retrieve license details for a user from Microsoft Entra ID.

## PARAMETERS

### -UserId

The object ID of the user for which the license details are retrieved. Specifies the ID of a user's UserPrincipalName or UserId in Microsoft Entra ID.

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

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
