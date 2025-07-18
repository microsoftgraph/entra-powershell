---
title: Set-EntraUserPassword
description: This article provides details on the Set-EntraUserPassword command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraUserPassword

schema: 2.0.0
---

# Set-EntraUserPassword

## Synopsis

Sets the password of a user.

## Syntax

```powershell
Set-EntraUserPassword
 [-ForceChangePasswordNextLogin <Boolean>]
 [-EnforceChangePasswordPolicy <Boolean>]
 -UserId <String>
 -Password <SecureString>
 [<CommonParameters>]
```

## Description

The `Set-EntraUserPassword` cmdlet sets the password for a user in Microsoft Entra ID.

Any user can update their password without belonging to any administrator role.

## Examples

### Example 1: Set a user's password

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$newPassword = '<strong-password>'
$securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
Set-EntraUserPassword -UserId 'SawyerM@contoso.com' -Password $securePassword
```

This command sets the specified user's password.

- `-UserId` parameter specifies the ID of a user in Microsoft Entra ID.
- `-Password` parameter specifies the password to set.

### Example 2: Set a user's password with EnforceChangePasswordPolicy parameter

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$newPassword= '<strong-password>'
$securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force 
Set-EntraUserPassword -UserId 'SawyerM@contoso.com' -Password $securePassword -EnforceChangePasswordPolicy $True
```

This command sets the specified user's password with EnforceChangePasswordPolicy parameter.

- `-UserId` parameter specifies the ID of a user in Microsoft Entra ID.
- `-Password` parameter specifies the password to set.
- `-EnforceChangePasswordPolicy` parameter force the user to change their password, if set to true.

### Example 3: Set a user's password with ForceChangePasswordNextLogin parameter

```powershell
connect-Entra -Scopes 'Directory.AccessAsUser.All'
$newPassword= '<strong-password>'
$securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
Set-EntraUserPassword -UserId 'SawyerM@contoso.com' -Password $securePassword -ForceChangePasswordNextLogin $True
```

This command sets the specified user's password with ForceChangePasswordNextLogin parameter.

- `-ObjectId` parameter specifies the ID of a user in Microsoft Entra ID.
- `-Password` parameter specifies the password to set.
- `-ForceChangePasswordNextLogin` parameter forces a user to change their password during their next log in.

## Parameters

### -EnforceChangePasswordPolicy

If set to true, force the user to change their password.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ForceChangePasswordNextLogin

Forces a user to change their password during their next sign in.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -UserId

Specifies the ID of a user.

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

### -Password

Specifies the password.

```yaml
Type: System.SecureString
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
