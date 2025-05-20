---
title: Set-EntraBetaUserPassword
description: This article provides details on the Set-EntraBetaUserPassword command.

ms.topic: reference
ms.date: 07/24/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaUserPassword

schema: 2.0.0
---

# Set-EntraBetaUserPassword

## Synopsis

Sets the password of a user.

## Syntax

```powershell
Set-EntraBetaUserPassword
 -ObjectId <String>
 -Password <SecureString>
 [-ForceChangePasswordNextLogin <Boolean>]
 [-EnforceChangePasswordPolicy <Boolean>]
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaUserPassword` cmdlet sets the password for a user in Microsoft Entra ID.

Any user can update their password without belonging to any administrator role.

## Examples

### Example 1: Set a user's password

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$newPassword = '<strong-password>'
$securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
Set-EntraBetaUserPassword -ObjectId 'SawyerM@contoso.com' -Password $securePassword
```

This command sets the specified user's password.

- `-ObjectId` parameter specifies the ID of a user in Microsoft Entra ID.
- `-Password` parameter specifies the password to set.

### Example 2: Set a user's password with EnforceChangePasswordPolicy parameter

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$newPassword= '<strong-password>'
$securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force 
Set-EntraBetaUserPassword -ObjectId 'SawyerM@contoso.com' -Password $securePassword -EnforceChangePasswordPolicy $True
```

This command sets the specified user's password with EnforceChangePasswordPolicy parameter.

- `-ObjectId` parameter specifies the ID of a user in Microsoft Entra ID.
- `-Password` parameter specifies the password to set.
- `-EnforceChangePasswordPolicy` parameter force the user to change their password, if set to true.

### Example 3: Set a user's password with ForceChangePasswordNextLogin parameter

```powershell
connect-Entra -Scopes 'Directory.AccessAsUser.All'
$newPassword= '<strong-password>'
$securePassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
Set-EntraBetaUserPassword -ObjectId 'SawyerM@contoso.com' -Password $securePassword -ForceChangePasswordNextLogin $True
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

### -ObjectId

Specifies the ID of an object.

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
