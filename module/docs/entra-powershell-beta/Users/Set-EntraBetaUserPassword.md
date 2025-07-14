---
author: msewaweru
description: This article provides details on the Set-EntraBetaUserPassword command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/24/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaUserPassword
schema: 2.0.0
title: Set-EntraBetaUserPassword
---

# Set-EntraBetaUserPassword

## SYNOPSIS

Sets the password of a user.

## SYNTAX

```powershell
Set-EntraBetaUserPassword
 -UserId <String>
 -Password <SecureString>
 [-ForceChangePasswordNextLogin <Boolean>]
 [-EnforceChangePasswordPolicy <Boolean>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaUserPassword` cmdlet sets the password for a user in Microsoft Entra ID.

Any user can update their password without belonging to any administrator role.

## EXAMPLES

### Example 1: Set a user's password

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$newPassword = '<strong-password>'
$securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
Set-EntraBetaUserPassword -UserId 'SawyerM@contoso.com' -Password $securePassword
```

This command sets the specified user's password.

- `-UserId` parameter specifies the ID of a user in Microsoft Entra ID.
- `-Password` parameter specifies the password to set.

### Example 2: Set a user's password with EnforceChangePasswordPolicy parameter

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$newPassword= '<strong-password>'
$securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force 
Set-EntraBetaUserPassword -UserId 'SawyerM@contoso.com' -Password $securePassword -EnforceChangePasswordPolicy $True
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
Set-EntraBetaUserPassword -UserId 'SawyerM@contoso.com' -Password $securePassword -ForceChangePasswordNextLogin $True
```

This command sets the specified user's password with ForceChangePasswordNextLogin parameter.

- `-UserId` parameter specifies the ID of a user in Microsoft Entra ID.
- `-Password` parameter specifies the password to set.
- `-ForceChangePasswordNextLogin` parameter forces a user to change their password during their next log in.

## PARAMETERS

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

Specifies the ID of an object.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
