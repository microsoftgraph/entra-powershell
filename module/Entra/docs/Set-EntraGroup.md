---
title: Set-EntraGroup.
description: This article provides details on the Set-EntraGroup command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/07/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraGroup

## SYNOPSIS
Updates a specific group in Microsoft Entra ID.

## SYNTAX

```
Set-EntraGroup 
 -ObjectId <String>
 [-SecurityEnabled <Boolean>]  
 [-DisplayName <String>] 
 [-Description <String>]
 [-MailEnabled <Boolean>] 
 [-MailNickName <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraGroup cmdlet updates a group in Microsoft Entra ID.

## EXAMPLES

### Example 1: Update a group description
```powershell
PS C:\>Set-EntraGroup -ObjectId "11fa5e1e-737c-40c5-835e-416ae3959606" -Description "This is my new group"
```

This example demonstrates how to update a group description.  

### Example 2: Update a group display name
```powershell
PS C:\>Set-EntraGroup -ObjectId "11fa5e1e-737c-40c5-835e-416ae3959606" -DisplayName "Parents of Conto"
```

This command updates the display name of a specified group in Microsoft Entra ID.  

### Example 3: Update a group mail nickname
```powershell
PS C:\>Set-EntraGroup -ObjectId "11fa5e1e-737c-40c5-835e-416ae3959606" -MailNickName "newnickname"
```

This command updates the mail nickname of a specified group in Microsoft Entra ID.  

### Example 4: Update a group security enabled
```powershell
PS C:\>Set-EntraGroup -ObjectId "11fa5e1e-737c-40c5-835e-416ae3959606" -SecurityEnabled $true
```
This command updates the security enabled of a specified group in Microsoft Entra ID.  

### Example 5: Update a group mail enabled
```powershell
PS C:\>Set-EntraGroup -ObjectId "11fa5e1e-737c-40c5-835e-416ae3959606" -MailEnabled $true
```

This example demonstrates how to update a group mail enabled.  
  
## PARAMETERS

### -Description
Specifies a description.

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

### -DisplayName
Specifies a display name.

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

### -MailEnabled
Indicates whether mail is enabled.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MailNickName
Specifies a nickname for the mail.

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

### -ObjectId
Specifies the object ID of a group.

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

### -SecurityEnabled
Indicates whether security is enabled.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraGroup](Get-EntraGroup.md)

[New-EntraGroup](New-EntraGroup.md)

[Remove-EntraGroup](Remove-EntraGroup.md)

