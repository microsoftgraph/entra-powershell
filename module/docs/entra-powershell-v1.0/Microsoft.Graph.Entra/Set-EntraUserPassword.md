---
title: Set-EntraUserPassword.
description: This article provides details on the Set-EntraUserPassword command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Set-EntraUserPassword

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
 -ObjectId <String> 
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
Set-EntraUserPassword -ObjectId  'bbbbbbbb-1111-2222-3333-cccccccccccc' -Password $password
```

This command sets the specified user's password.

### Example 2: Set a user's password with EnforceChangePasswordPolicy parameter

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$params = @{
    ObjectId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
    Password = $password
    EnforceChangePasswordPolicy = $true
}

Set-EntraUserPassword @params
```

This command sets the specified user's password with EnforceChangePasswordPolicy parameter.

### Example 3: Set a user's password with ForceChangePasswordNextLogin parameter

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$params = @{
    ObjectId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
    Password = $password
    ForceChangePasswordNextLogin = $true
}

Set-EntraUserPassword @params
```

This command sets the specified user's password with ForceChangePasswordNextLogin parameter.

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
