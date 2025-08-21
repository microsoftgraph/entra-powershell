---
author: msewaweru
description: This article provides details on the Set-EntraUserPasswordProfile command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraUserPasswordProfile
schema: 2.0.0
title: Set-EntraUserPasswordProfile
---

# Set-EntraUserPasswordProfile

## SYNOPSIS

Sets the password of a user.

## SYNTAX

```powershell
Set-EntraUserPasswordProfile
 [-ForceChangePasswordNextSignIn]
 [-ForceChangePasswordNextSignInWithMfa]
 -UserId <String>
 -Password <SecureString>
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraUserPasswordProfile` cmdlet with alias `Set-EntraUserPassword` sets the password for a user in Microsoft Entra ID.

Any user can update their password without belonging to any administrator role.

## EXAMPLES

### Example 1: Set a user's password

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$newPassword = '<strong-password>'
$securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
Set-EntraUserPasswordProfile -UserId 'SawyerM@contoso.com' -Password $securePassword
```

This command sets the specified user's password.

- `-UserId` parameter specifies the ID of a user in Microsoft Entra ID.
- `-Password` parameter specifies the password to set.

### Example 2: Set a user's password with ForceChangePasswordNextSignInWithMfa parameter

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$newPassword= '<strong-password>'
$securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force 
Set-EntraUserPasswordProfile -UserId 'SawyerM@contoso.com' -Password $securePassword -ForceChangePasswordNextSignInWithMfa
```

This command sets the specified user's password with ForceChangePasswordNextSignInWithMfa parameter.

- `-UserId` parameter specifies the ID of a user in Microsoft Entra ID.
- `-Password` parameter specifies the password to set.
- `-ForceChangePasswordNextSignInWithMfa` parameter force the user to change their password.

### Example 3: Set a user's password with ForceChangePasswordNextSignIn parameter

```powershell
connect-Entra -Scopes 'Directory.AccessAsUser.All'
$newPassword= '<strong-password>'
$securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
Set-EntraUserPasswordProfile -UserId 'SawyerM@contoso.com' -Password $securePassword -ForceChangePasswordNextSignIn
```

This command sets the specified user's password with ForceChangePasswordNextSignIn parameter.

- `-UserId` parameter specifies the ID of a user in Microsoft Entra ID.
- `-Password` parameter specifies the password to set.
- `-ForceChangePasswordNextSignIn` parameter forces a user to change their password during their next log in.

## PARAMETERS

### -ForceChangePasswordNextSignInWithMfa

If set to true, force the user to change their password.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceChangePasswordNextSignIn

Forces a user to change their password during their next sign in.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserId

Specifies the ID of a user.

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
