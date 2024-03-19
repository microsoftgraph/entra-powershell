---
title: New-EntraMSGroup.
description: This article provides details on the New-EntraMSGroup command.

ms.service: active-directory
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

# New-EntraMSGroup

## SYNOPSIS
Creates a Microsoft Entra ID group.

## SYNTAX

```
New-EntraMSGroup 
-DisplayName <String> 
[-GroupTypes <System.Collections.Generic.List`1[System.String]>]
-SecurityEnabled <Boolean> 
[-Description <String>] 
-MailEnabled <Boolean> 
-MailNickname <String>
[-Visibility <String>] 
[-IsAssignableToRole <Boolean>] 
[<CommonParameters>]
```

## DESCRIPTION
The New-EntraMSGroup cmdlet creates a Microsoft Entra ID group.

For information about creating dynamic groups, see Using attributes to create advanced rules (https://azure.microsoft.com/en-us/documentation/articles/active-directory-accessmanagement-groups-with-advanced-rules/).

## EXAMPLES

### Example 1: Create a group.

```powershell
PS C:\> New-EntraMSGroup -DisplayName "HelpDesk admin group2"  -MailEnabled $False -MailNickname "helpDeskAdminGroup" -SecurityEnabled $True
```

```output

DisplayName           Id                                   MailNickname       Description GroupTypes
-----------           --                                   ------------       ----------- ----------
HelpDesk admin group2 68563e90-3cbb-408a-beb6-ea93f7b5b4d4 helpDeskAdminGroup             {}

```
This example demonstrates how to create the new group.

### Example 2: Create a group with Description parameter.

```powershell
PS C:\>  New-EntraMSGroup -DisplayName "HelpDesk admin group"  -MailEnabled $false -MailNickname "helpDeskAdminGroup" -SecurityEnabled $true  -Description "Group assignable to role"
```

```output

DisplayName          Id                                   MailNickname       Description              GroupTypes
-----------          --                                   ------------       -----------              ----------
HelpDesk admin group dcbf038d-613c-498f-a695-28199246d9ee helpDeskAdminGroup Group assignable to role {}

```
This example demonstrates how to create the new group with description parameter.

### Example 3: Create a group with IsAssignableToRole parameter.

```powershell
PS C:\>  New-EntraMSGroup -DisplayName "HelpDesk admin group2" -Description "Group assignable to role" -MailEnabled $False -MailNickname "helpDeskAdminGroup" -SecurityEnabled $True -IsAssignableToRole $True 
```

```output

DisplayName           Id                                   MailNickname       Description              GroupTypes
-----------           --                                   ------------       -----------              ----------
HelpDesk admin group2 380f8097-ecd8-4d0b-b553-5ba1f53d16a7 helpDeskAdminGroup Group assignable to role {}

```
This example demonstrates how to create the new group with IsAssignableToRole parameter.

### Example 4: Create a group with Visibility parameter.

```powershell
PS C:\>  New-EntraMSGroup -DisplayName "HelpDesk admin group2" -Description "Group assignable to role" -MailEnabled $False -MailNickname "helpDeskAdminGroup" -SecurityEnabled $True -Visibility "Private"
```

```output

DisplayName           Id                                   MailNickname       Description              GroupTypes
-----------           --                                   ------------       -----------              ----------
HelpDesk admin group2 380f8097-ecd8-4d0b-b553-5ba1f53d16a7 helpDeskAdminGroup Group assignable to role {}

```
This example demonstrates how to create the new group with Visibility parameter.

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

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MailEnabled
Specifies whether this group is mail enabled.

Currently, you can't create mail enabled groups in  Microsoft Entra ID.

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

### -MailNickname
Specifies a mail nickname for the group.
If MailEnabled is $False, you must still specify a mail nickname.

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
Specifies whether the group is security enabled.
For security groups, this value must be $True.

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

### -Visibility
This parameter determines the visibility of the group's content and members list.
This parameter can take one of the following values:

* Public: Anyone can view the contents of the group.
* Private: Only members can view the content of the group.
* HiddenMembership:  Only members can view the content of the group and only members, owners, Global/Company Administrator, User Administrator, and Helpdesk Administrators can view the members list of the group.

If no value is provided, the default value is "Public."

Notes:

* This parameter is only valid for groups that have the groupType set to "Unified."
* If a group has this attribute set to "HiddenMembership," it can't be changed later.
* Anyone can join a group that has this attribute set to "Public" If the attribute is set to Private or HiddenMembership, only owner(s) can add new members to the group and requests to join the group need approval of the owner(s).

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
Indicates whether group can be assigned to a role. This property can only be set at the time of group creation and can't be modified on an existing group.

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

### None
## OUTPUTS

### System.Object
## NOTES
This cmdlet is currently in Public Preview.
While a cmdlet is in Public Preview, we might make changes to the cmdlet, which could have unexpected effects.
We recommend that you don't use this cmdlet in a production environment.

## RELATED LINKS

[Get-EntraMSGroup](Get-EntraMSGroup.md)

[Remove-EntraMSGroup](Remove-EntraMSGroup.md)

[Set-EntraMSGroup](Set-EntraMSGroup.md)

[Using attributes to create advanced rules](https://azure.microsoft.com/en-us/documentation/articles/active-directory-accessmanagement-groups-with-advanced-rules/)

