---
title: Set-EntraUserPassword.
description: This article provides details on the Set-EntraUserPassword command.

ms.service: entra
ms.topic: reference
ms.date: 03/18/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
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
The Set-EntraUserPassword cmdlet sets the password for a user in Microsoft Entra ID.

## Examples

### Example 1: Set a user's password.

```powershell
PS C:\>Set-EntraUserPassword -ObjectId  "df19e8e6-2ad7-453e-87f5-037f6529ae16" -Password $password
```
This command sets the specified user's password.

### Example 2: Set a user's password with EnforceChangePasswordPolicy parameter.

```powershell
PS C:\>Set-EntraUserPassword -ObjectId  "df19e8e6-2ad7-453e-87f5-037f6529ae16" -Password $password -EnforceChangePasswordPolicy $true

```
This command sets the specified user's password with EnforceChangePasswordPolicy parameter.

### Example 3: Set a user's password with ForceChangePasswordNextLogin parameter.

```powershell
PS C:\>Set-EntraUserPassword -ObjectId  "df19e8e6-2ad7-453e-87f5-037f6529ae16" -Password $password -ForceChangePasswordNextLogin $true
```

This command sets the specified user's password with ForceChangePasswordNextLogin parameter.

## Parameters

### -EnforceChangePasswordPolicy
If set to true, force the user to change their password.

```yaml
Type: Boolean
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
Type: Boolean
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
Type: String
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
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS
