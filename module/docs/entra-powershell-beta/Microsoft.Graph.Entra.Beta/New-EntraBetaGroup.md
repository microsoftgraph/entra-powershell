---
title: New-EntraBetaGroup.
description: This article provides details on the New-EntraBetaGroup command.

ms.service: active-directory
ms.topic: reference
ms.date: 06/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# New-EntraBetaGroup

## SYNOPSIS
Creates a group.

## SYNTAX

```powershell
New-EntraBetaGroup 
 -DisplayName <String> 
 -SecurityEnabled <Boolean>
 [-Description <String>] 
 -MailEnabled <Boolean> 
 -MailNickName <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The New-EntraBetaGroup cmdlet creates a group in Microsoft Entra ID.

## EXAMPLES

### Example 1: Create a group
```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Group.Create' #Application permission
New-EntraBetaGroup -DisplayName "My new group" -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet"
```

```output
DisplayName  Id                                   MailNickname Description GroupTypes
-----------  --                                   ------------ ----------- ----------
My new group fa484609-c1b0-4f38-a4f6-395cd2ebe18c NotSet                   {}
```

### Example 2: Create a group with Description parameter

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Group.Create' #Application permission
New-EntraBetaGroup -DisplayName 'My new group' -MailEnabled $false -SecurityEnabled $true -MailNickName 'NotSet' -Description 'New created group'
```

```output
DisplayName  Id                                   MailNickname Description       GroupTypes
-----------  --                                   ------------ -----------       ----------
My new group hhhhhhhh-8888-9999-8888-cccccccccccc NotSet       new created group {}
```

This example demonstrates how to create a group with Description parameter.


## PARAMETERS

### -Description
Specifies a description of the group.

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
Specifies the display name of the group.

```yaml
Type: System.String
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
Type: System.Boolean
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
Type: System.String
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
Type: System.Boolean
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

[Get-EntraBetaGroup](Get-EntraBetaGroup.md)

[Remove-EntraBetaGroup](Remove-EntraBetaGroup.md)

[Set-EntraBetaGroup](Set-EntraBetaGroup.md)
