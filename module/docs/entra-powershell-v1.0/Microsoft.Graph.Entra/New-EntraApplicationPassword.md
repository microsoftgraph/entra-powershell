---
title: New-EntraApplicationPassword
description: This article provides details on the New-EntraApplicationPassword command.

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

# New-EntraApplicationPassword

## Synopsis
Adds a strong password to an application.

## Syntax

```powershell
New-EntraApplicationPassword 
 -ObjectId <String> 
 -PasswordCredential <PasswordCredential> 
 [<CommonParameters>]
```

## Description
Adds a strong password to an application.

## Examples

### Example 1: Add a password to an application
```powershell
PS C:\> New-EntraApplicationPassword -ObjectId 14a3f1ac-46a7-4d00-b1ca-0b2b84f033c2 -PasswordCredential @{ displayname = "mypassword" }
```

```output
CustomKeyIdentifier DisplayName EndDateTime           Hint KeyId                                SecretText                       StartDateTime
------------------- ----------- -----------           ---- -----                                ----------                       -------------
                    mypassword  10/28/2021 3:57:37 PM EQ:  024c4c6e-87c3-4473-8e36-650f16bb730d EQ:A-s45?Rt9/3Bp?7]-7__IO]3AG09E 10/28/2019 3:57:37 PM
```

This command Adds a password to the specified application.

## Parameters

### -ObjectId
The unique identifier of the object specific Microsoft Entra ID object

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

### -PasswordCredential
Represents a password credential associated with an application or a service principal.

```yaml
Type: PasswordCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### String
### Microsoft.Open.MSGraph.Model.PasswordCredential
## Outputs

### Microsoft.Open.MSGraph.Model.PasswordCredential
## Notes

## Related Links

[Remove-EntraApplicationPassword](Remove-EntraApplicationPassword.md)

