---
title: New-EntraGroup.
description: This article provides details on the New-EntraGroup command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraGroup

## SYNOPSIS
Creates a group.

## SYNTAX

```powershell
New-EntraGroup 
 -DisplayName <String> 
 -SecurityEnabled <Boolean> 
 [-Description <String>] 
 -MailEnabled <Boolean>
 -MailNickName <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The New-EntraGroup cmdlet creates a group in Microsoft Entra ID.

## EXAMPLES

### Example 1: Create a group.

```powershell
PS C:\>New-EntraGroup -DisplayName "My new group" -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet"
```
```output

DisplayName  Id                                   MailNickname Description GroupTypes
-----------  --                                   ------------ ----------- ----------
My new group 866fc97b-1171-4330-b4d0-d07f2cc8117b NotSet                   {}
```
This example demonstrates how to create a group.

### Example 2: Create a group with Description parameter.

```powershell
PS C:\>New-EntraGroup -DisplayName "My new group" -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet" -Description "new created group"

```
```output
DisplayName  Id                                   MailNickname Description       GroupTypes
-----------  --                                   ------------ -----------       ----------
My new group ab0a6502-2201-412f-9ca8-fae1558a8470 NotSet       new created group {}


```
This example demonstrates how to create a group with Description parameter.


## PARAMETERS

### -Description
Specifies a description of the group.

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
Specifies the display name of the group.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MailNickName
Specifies a nickname for mail.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecurityEnabled
Indicates whether the group is security-enabled.

```yaml
Type: Boolean
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraGroup](Get-EntraGroup.md)

[Remove-EntraGroup](Remove-EntraGroup.md)

[Set-EntraGroup](Set-EntraGroup.md)

