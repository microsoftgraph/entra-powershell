---
title: Get-EntraGroupAppRoleAssignment
description: This article provides details on the Get-EntraGroupAppRoleAssignment command.

ms.service: active-directory
ms.topic: reference
ms.date: 02/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraGroupAppRoleAssignment

## SYNOPSIS

Gets a group application role assignment.

## SYNTAX

```powershell
Get-EntraGroupAppRoleAssignment 
 -ObjectId <String> 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION

The Get-EntraGroupAppRoleAssignment cmdlet gets a group application role assignment in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve application role assignments of a group

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$GroupId = (Get-EntraGroup -Top 1).ObjectId
Get-EntraGroupAppRoleAssignment -ObjectId $GroupId
```

```output
ObjectId                                    ResourceDisplayName                 PrincipalDisplayName
--------                                    -------------------                 --------------------
AaBbCcDdEeFfGgHhIiJjKkLlMmNnOo1 Microsoft Resource One             Ask HR
BbCcDdEeFfGgHhIiJjKkLlMmNnOoPp2 Microsoft Resource Two             Ask HR
CcDdEeFfGgHhIiJjKkLlMmNnOoPpQq3 Microsoft Resource Three           Ask HR
```

The first command gets the object ID of a group by using the [Get-EntraGroup](./Get-EntraGroup.md) cmdlet.
The command stores the ID in the $GroupId variable.

The second command gets the application role assignments of the group in $GroupId.

### Example 2: Retrieve all application role assignments of a group

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraGroupAppRoleAssignment -ObjectId 'ffffffffff-7777-9999-7777-vvvvvvvvvvv' -All
```

```output
ObjectId                                    ResourceDisplayName                 PrincipalDisplayName
--------                                    -------------------                 --------------------
AaBbCcDdEeFfGgHhIiJjKkLlMmNnOo1 Microsoft Resource One             Ask HR
BbCcDdEeFfGgHhIiJjKkLlMmNnOoPp2 Microsoft Resource Two             Ask HR
CcDdEeFfGgHhIiJjKkLlMmNnOoPpQq3 Microsoft Resource Three           Ask HR
```

This command gets all application role assignments of the specified group.

### Example 3: Retrieve top two application role assignments of a group

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraGroupAppRoleAssignment -ObjectId 'ffffffffff-7777-9999-7777-vvvvvvvvvvv' -Top 2
```

```output
ObjectId                                    ResourceDisplayName                 PrincipalDisplayName
--------                                    -------------------                 --------------------
AaBbCcDdEeFfGgHhIiJjKkLlMmNnOo1 Microsoft Resource One             Ask HR
BbCcDdEeFfGgHhIiJjKkLlMmNnOoPp2 Microsoft Resource Two             Ask HR
```

This command gets top two application role assignments of the specified group.

## PARAMETERS

### -All

If true, return all application role assignments.
If false, return the number of objects specified by the Top parameter.

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

Specifies the ID of a group in Microsoft Entra ID.

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

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraGroup](Get-EntraGroup.md)

[New-EntraGroupAppRoleAssignment](New-EntraGroupAppRoleAssignment.md)

[Remove-EntraGroupAppRoleAssignment](Remove-EntraGroupAppRoleAssignment.md)
