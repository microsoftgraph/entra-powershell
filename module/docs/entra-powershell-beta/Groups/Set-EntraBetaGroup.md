---
author: msewaweru
description: This article provides details on the Set-EntraBetaGroup command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaGroup
schema: 2.0.0
title: Set-EntraBetaGroup
---

# Set-EntraBetaGroup

## SYNOPSIS

Sets the properties for an existing Microsoft Entra ID group.

## SYNTAX

```powershell
Set-EntraBetaGroup
 -GroupId <String>
 [-GroupTypes <System.Collections.Generic.List`1[System.String]>]
 [-DisplayName <String>]
 [-Description <String>]
 [-IsAssignableToRole <Boolean>]
 [-SecurityEnabled <Boolean>]
 [-Visibility <String>]
 [-MailEnabled <Boolean>]
 [-MailNickname <String>]
 [-MembershipRule <String>]
 [-MembershipRuleProcessingState <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaGroup` cmdlet sets the properties for an existing Microsoft Entra ID group. Specify the `GroupId` parameter to set the properties for an existing Microsoft Entra ID group.

## EXAMPLES

### Example 1: Update a group display name

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
Set-EntraBetaGroup -GroupId $group.Id -DisplayName 'Global HelpDesk Team Leaders'
```

This command updates the display name of a specified group in Microsoft Entra ID.

### Example 2: Update a group description

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
Get-EntraBetaGroup -Filter "displayName eq 'HelpDesk Team Leaders'" | Set-EntraBetaGroup -Description 'HelpDesk Team Leaders Global'
```

This example demonstrates how to update a group description.  

### Example 3: Update a group mail nickname

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
Set-EntraBetaGroup -GroupId $group.Id -MailNickName 'newnickname'
```

This command updates the mail nickname of a specified group in Microsoft Entra ID.

### Example 4: Update a group security enabled

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
Get-EntraBetaGroup -Filter "displayName eq 'HelpDesk Team Leaders'" | Set-EntraBetaGroup -SecurityEnabled $true
```

This command updates the security enabled of a specified group in Microsoft Entra ID.

### Example 5: Update a group mail enabled

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
Set-EntraBetaGroup -GroupId $group.Id -MailEnabled $False
```

This example demonstrates how to update a group main enabled.  

### Example 6: Update a property for a group

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
Set-EntraBetaGroup -GroupId $group.Id -Visibility 'Private' -GroupTypes 'DynamicMembership' -IsAssignableToRole $True
```

This example demonstrates how to update a property for an existing Microsoft Entra ID group.  

### Example 7: Update a group membership rule

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
Set-EntraBetaGroup -GroupId $group.Id -MembershipRule '(user.UserType -contains "Member")'
```

This example demonstrates how to update the membership rule of a specified group in Microsoft Entra ID.

### Example 8: Update a group membership rule processing state

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'HelpDesk Team Leaders'"
Set-EntraBetaGroup -GroupId $group.Id -MembershipRule '(user.UserType -contains "Member")'
```

This example demonstrates how to update the membership rule processing state of a specified group in Microsoft Entra ID.

## PARAMETERS

### -Description

Specifies a description for the group.

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

Specifies a display name for the group.

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

### -GroupId

Specifies the object ID of a group.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -IsAssignableToRole

This property can only be set at the time of group creation and can't be modified on an existing group.

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

### -MailEnabled

Indicates whether this group is mail enabled.

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

### -MailNickname

Specifies a mail nickname for the group.

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

### -MembershipRule

The rule that determines members for this group if the group is a dynamic group (groupTypes contains DynamicMembership)

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

### -MembershipRuleProcessingState

Indicates whether the dynamic membership processing is on or paused. Possible values are On or Paused.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecurityEnabled

Indicates whether the group is security enabled.

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

### -Visibility

Specifies the visibility of the group's content and members list.
This parameter can take one of the following values:

* "Public": Anyone can view the contents of the group.
* "Private": Only members can view the content of the group.
* "HiddenMembership": Only members can view the content of the group and only members, owners, Global/Company Administrator, User Administrator, and Helpdesk Administrators can view the members list of the group.

If no value is provided, the default value is "Public."

Notes:

* This parameter is only valid for groups that have the groupType set to "Unified."
* If a group has this attribute set to "HiddenMembership," it can't be changed later.
* Anyone can join a group that has this attribute set to "Public." If the attribute is set to Private or HiddenMembership, only owner can add new members to the group and requests to join the group need approval of the owner.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraBetaGroup](Get-EntraBetaGroup.md)

[New-EntraBetaGroup](New-EntraBetaGroup.md)

[Remove-EntraBetaGroup](Remove-EntraBetaGroup.md)
