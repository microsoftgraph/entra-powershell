---
description: This article provides details on the Get-EntraConditionalAccessPolicy command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraConditionalAccessPolicy
schema: 2.0.0
title: Get-EntraConditionalAccessPolicy
---

# Get-EntraConditionalAccessPolicy

## SYNOPSIS

Gets a Microsoft Entra ID conditional access policy.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraConditionalAccessPolicy
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraConditionalAccessPolicy
 -PolicyId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet allows an admin to get the Microsoft Entra ID conditional access policy. Conditional access policies are custom rules that define an access scenario.

In delegated scenarios involving work or school accounts, the signed-in user must have a Microsoft Entra role or a custom role with the required permissions to act on behalf of another user. The following least privileged roles support this operation:

- Global Secure Access Administrator (read standard properties)  
- Security Reader (read standard properties)  
- Security Administrator (read standard properties)  
- Global Reader  
- Conditional Access Administrator 

In delegated scenarios involving work or school accounts, the signed-in user must have a Microsoft Entra role or a custom role with the required permissions to act on behalf of another user. The following least privileged roles support this operation:

- Global Secure Access Administrator (read standard properties)  
- Security Reader (read standard properties)  
- Security Administrator (read standard properties)  
- Global Reader  
- Conditional Access Administrator  

## EXAMPLES

### Example 1: Retrieves a list of all conditional access policies in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraConditionalAccessPolicy
```

```Output
Id                                   CreatedDateTime      Description DisplayName                ModifiedDateTime     State    TemplateId
--                                   ---------------      ----------- -----------                ----------------     -----    ----------
eeeeeeee-4444-5555-6666-ffffffffffff 2/27/2024 6:23:21 AM             ConditionalAccessPolicy    2/29/2024 2:41:17 PM disabled
ffffffff-5555-6666-7777-aaaaaaaaaaaa 2/27/2024 6:26:00 AM             ConditionalAccessPolicy    2/29/2024 2:41:34 PM disabled
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb 2/27/2024 6:30:48 AM             ConditionalAccessPolicy    2/29/2024 2:43:53 PM disabled
```

This example retrieves a list of all conditional access policies in Microsoft Entra ID.

### Example 2: Retrieves a conditional access policy in Microsoft Entra ID with given ID

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
$policy = Get-EntraConditionalAccessPolicy | Where-Object { $_.DisplayName -eq 'Multifactor authentication for Contoso partners and vendors' }
Get-EntraConditionalAccessPolicy -PolicyId $policy.Id
```

```Output
Id                                    CreatedDateTime        Description                  DisplayName                  ModifiedDateTime       State     TemplateId
--                                    ---------------        -----------                  -----------                  ----------------       -----     ----------
eeeeeeee-4444-5555-6666-ffffffffffff  2/27/2024 6:23:21 AM   Multifactor authentication   2/29/2024 2:41:17 PM         disabled
```

This example retrieves a specified conditional access policy in Microsoft Entra ID.

- `-PolicyId` parameter specifies the Id of a conditional access policy.

## PARAMETERS

### -PolicyId

Specifies the ID of a conditional access policy in Microsoft Entra ID.

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

[New-EntraConditionalAccessPolicy](New-EntraConditionalAccessPolicy.md)

[Set-EntraConditionalAccessPolicy](Set-EntraConditionalAccessPolicy.md)

[Remove-EntraConditionalAccessPolicy](Remove-EntraConditionalAccessPolicy.md)
