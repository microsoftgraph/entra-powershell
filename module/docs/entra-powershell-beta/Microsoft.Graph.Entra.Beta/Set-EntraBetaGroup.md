---
title: Set-EntraBetaGroup.
description: This article provides details on the Set-EntraBetaGroup command.

ms.service: entra
ms.topic: reference
ms.date: 06/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Set-EntraBetaGroup

## SYNOPSIS

Updates a specific group in Microsoft Entra ID.

## SYNTAX

```powershell
Set-EntraBetaGroup 
 -ObjectId <String> 
 [-Description <String>] 
 [-MailEnabled <Boolean>]
 [-SecurityEnabled <Boolean>] 
 [-MailNickName <String>] 
 [-DisplayName <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaGroup` cmdlet updates a group in Microsoft Entra ID. Specify `ObjectId` parameter to update a specific group in Microsoft Entra ID.

## EXAMPLES

### Example 1: Update a group description

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
Set-EntraBetaGroup -ObjectId 'kkkkkkkk-3333-5555-1111-nnnnnnnnnnnn' -Description 'This is my new group'
```

This example demonstrates how to update a group description.  

### Example 2: Update a group display name

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
Set-EntraBetaGroup -ObjectId 'kkkkkkkk-3333-5555-1111-nnnnnnnnnnnn' -DisplayName 'Parents of Conto'
```

This command updates the display name of a specified group in Microsoft Entra ID.  

### Example 3: Update a group mail nickname

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
Set-EntraBetaGroup -ObjectId 'kkkkkkkk-3333-5555-1111-nnnnnnnnnnnn' -MailNickName 'newnickname'
```

This command updates the mail nickname of a specified group in Microsoft Entra ID.  

### Example 4: Update a group security enabled

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
Set-EntraBetaGroup -ObjectId 'kkkkkkkk-3333-5555-1111-nnnnnnnnnnnn' -SecurityEnabled $true
```

This command updates the security enabled of a specified group in Microsoft Entra ID.  

### Example 5: Update a group mail enabled

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
Set-EntraBetaGroup -ObjectId 'kkkkkkkk-3333-5555-1111-nnnnnnnnnnnn' -MailEnabled $true
```

This example demonstrates how to enable a group mail.

## PARAMETERS

### -Description

Specifies a description.

```yaml
Type: System.String
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
Type: System.String
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
Type: System.Boolean
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
Type: System.String
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
Type: System.String
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
Type: System.Boolean
Parameter Sets: (All)
Aliases:

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

[Get-EntraBetaGroup](Get-EntraBetaGroup.md)

[New-EntraBetaGroup](New-EntraBetaGroup.md)

[Remove-EntraBetaGroup](Remove-EntraBetaGroup.md)
