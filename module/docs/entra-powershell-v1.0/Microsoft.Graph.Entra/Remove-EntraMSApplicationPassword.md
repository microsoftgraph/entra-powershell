---
title: Remove-EntraMSApplicationPassword.
description: This article provides details on the Remove-EntraMSApplicationPassword command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSApplicationPassword

## SYNOPSIS
Remove a password from an application.

## SYNTAX

```
Remove-EntraMSApplicationPassword 
-ObjectId <String> 
[-KeyId <String>] 
[<CommonParameters>]
```

## DESCRIPTION
Remove a password from an application.

## EXAMPLES

### Example 1: Removes a password from an application
```
PS C:\>Remove-EntraMSApplicationPassWord -ObjectId 1f88e99f-37a3-468f-80ae-e07b62ed0287 -KeyId 80e561ed-44ed-48dc-8c09-9d4803e26e4c
```

This command remove the specified password from the specified application.  
ObjectId: The ObjectId of the specified application.
KeyID: The unique identifier of the PasswordCredential.  

## PARAMETERS

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

### -KeyId
The unique identifier for the key.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### string
## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraMSApplicationPassword](New-EntraMSApplicationPassword.md)

