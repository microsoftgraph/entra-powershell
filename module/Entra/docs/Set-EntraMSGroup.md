---
title: Set-EntraMSGroup.
description: This article provides details on the Set-EntraMSGroup command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraMSGroup

## SYNOPSIS
Sets the properties for an existing Microsoft Entra ID group.

## SYNTAX

```
Set-EntraMSGroup 
 -Id <String>
 [-DisplayName <String>] 
 [-GroupTypes <System.Collections.Generic.List`1[System.String]>]
 [-SecurityEnabled <Boolean>]  
 [-Description <String>] 
 [-MailEnabled <Boolean>]
 [-MailNickname <String>] 
 [-Visibility <String>] 
 [-IsAssignableToRole <Boolean>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraMSGroup cmdlet sets the properties for an existing Microsoft Entra ID group.

## EXAMPLES

### Example 1: Update a group display name
```powershell
PS C:\> Set-EntraMSGroup -Id 2c199eed-f77f-4cf4-9270-299071598fa7 -DisplayName "UPDATE helpdesk"
```

This example demonstrates how to update a group display name.  

This command updates the display name of a specified group in Microsoft Entra ID.

### Example 2: Update a group description
```powershell
PS C:\> Set-EntraMSGroup -Id 2c199eed-f77f-4cf4-9270-299071598fa7 -Description "This is my new group"
```

This example demonstrates how to update a group description.  

This command updates the description of a specified group in Microsoft Entra ID.

### Example 3: Update a group mail nickname
```powershell
PS C:\> Set-EntraMSGroup -Id 2c199eed-f77f-4cf4-9270-299071598fa7 -MailNickName "newnickname"
```

This example demonstrates how to update a group mail nickname.  

This command updates the mail nickname of a specified group in Microsoft Entra ID.

### Example 4: Update a group security enabled
```powershell
PS C:\>  Set-EntraMSGroup -Id 2c199eed-f77f-4cf4-9270-299071598fa7 -SecurityEnabled $true
```

This example demonstrates how to update a group security enabled.  

This command updates the security enabled of a specified group in Microsoft Entra ID.

### Example 5: Update a group mail enabled
```powershell
PS C:\> Set-EntraMSGroup -Id 2c199eed-f77f-4cf4-9270-299071598fa7 -MailEnabled $false
```

This example demonstrates how to update a group main enabled.  

This command updates the mail enabled of a specified group in Microsoft Entra ID.

### Example 6: Update a properties for a group
```powershell
PS C:\>  Set-EntraMSGroup -Id 2c199eed-f77f-4cf4-9270-299071598fa7 -Visibility "Private" -GroupTypes "DynamicMembership" -IsAssignableToRole $true
```

This example demonstrates how to update a properties for an existing Microsoft Entra ID group.  

This command updates the properties of a specified group in Microsoft Entra ID.

## PARAMETERS

### -Description
Specifies a description for the group.

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
Specifies a display name for the group.

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

### -GroupTypes
Specifies that the group is a dynamic group. 
To create a dynamic group, specify a value of DynamicMembership.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
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

### -MailEnabled
Indicates whether this group is mail enabled.

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

### -MailNickname
Specifies a mail nickname for the group.

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

### -SecurityEnabled
Indicates whether the group is security enabled.

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

### -Visibility
Specifies the visibility of the group's content and members list.
This parameter can take one of the following values:

* "Public" - Anyone can view the contents of the group
* "Private" - Only members can view the content of the group
* "HiddenMembership" - Only members can view the content of the group and only members, owners, Global/Company Administrator, User Administrator and Helpdesk Administrators can view the members list of the group.

If no value is provided, the default value will be "Public".

Notes:

* This parameter is only valid for groups that have the groupType set to "Unified".
* If a group has this attribute set to "HiddenMembership" it cannot be changed later.
* Anyone can join a group that has this attribute set to "Public". If the attribute is set to Private or HiddenMembership, only owner(s) can add new members to the group and requests to join the group need approval of the owner(s).

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

### -IsAssignableToRole
This property can only be set at the time of group creation and cannot be modified on an existing group.

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

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Get-EntraMSGroup](Get-EntraMSGroup.md)

[New-EntraMSGroup](New-EntraMSGroup.md)

[Remove-EntraMSGroup](Remove-EntraMSGroup.md)