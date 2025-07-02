---
author: msewaweru
description: This article provides details on the New-EntraBetaAdministrativeUnitMember command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/04/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaAdministrativeUnitMember
schema: 2.0.0
title: New-EntraBetaAdministrativeUnitMember
---

# New-EntraBetaAdministrativeUnitMember

## Synopsis

Create a new object as a member of the administrative unit.
Currently only group objects are supported.

## Syntax

```powershell
New-EntraBetaAdministrativeUnitMember
 -AdministrativeUnitId <String>
 [-GroupTypes <System.Collections.Generic.List`1[System.String]>]
 [-AssignedLabels <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AssignedLabel]>]
 [-OdataType <String>]
 [-Description <String>]
 -SecurityEnabled <Boolean>
 [-IsAssignableToRole <Boolean>]
 [-ProxyAddresses <System.Collections.Generic.List`1[System.String]>]
 -DisplayName <String>
 [-Visibility <String>]
 -MailEnabled <Boolean>
 -MailNickname <String>
 [-MembershipRule <String>]
 [-MembershipRuleProcessingState <String>]
 [<CommonParameters>]
```

## Description

The `New-EntraBetaAdministrativeUnitMember` cmdlet creates a Microsoft Entra ID object as a member of an administrative unit. Specify `AdministrativeUnitId`, `DisplayName`, `MailNickname`, `SecurityEnabled` and `MailEnabled` parameters for create a new administrative unit member.

Currently only Microsoft Entra ID groups are supported to create administrative unit members.

For information about creating dynamic groups, see [Using attributes to create advanced rules](https://learn.microsoft.com/entra/identity/users/groups-dynamic-membership).

## Examples

### Example 1: Create a dynamic group in an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
$params = @{
    AdministrativeUnitId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
    OdataType = 'Microsoft.Graph.Group'
    DisplayName = 'NewAUMember'
    Description = 'createdUnitMember'
    MailEnabled = $True
    MailNickname = 'new'
    SecurityEnabled = $False
    GroupTypes = @('Unified', 'DynamicMembership')
    MembershipRule = "(user.department -contains 'Marketing')"
    MembershipRuleProcessingState = 'On'
    IsAssignableToRole = $false
    Visibility = 'Public'
    ProxyAddresses = @('SMTP:Ahiresh@M365x99297270.onmicrosoft.com')
}
New-EntraBetaAdministrativeUnitMember @params
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
dddddddd-2222-2222-3333-cccccccccccc
```

This command creates a new dynamic group in an administrative unit with the following rule:

\`user.department -contains "Marketing"\`

The double quotation marks are replaced with single quotation marks.

The processing state is On.
It means that all users in the directory that qualify the rule are added as members to the group.
Any users that don't qualify are removed from the group.

## Parameters

### -AdministrativeUnitId

Specifies the AdministrativeUnitId of a Microsoft Entra ID administrative unit.

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

### -OdataType

Specifies the odata type of the object to create in the administrative unit.

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

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MailEnabled

Specifies whether this group is mail enabled.

Currently, you can't create mail enabled groups in Microsoft Entra ID.

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

### -MailNickname

Specifies a mail nickname for the group.
If MailEnabled is $False, you must still specify a mail nickname.

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

Specifies whether the group is security enabled.
For security groups, this value must be $True.

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

### -MembershipRule

Specifies the membership rule for a dynamic group.

For more information about the rules that you can use for dynamic groups, [Using attributes to create advanced rules](https://learn.microsoft.com/entra/identity/users/groups-dynamic-membership)

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

Specifies the rule processing state.
The acceptable values for this parameter are:

* "On". Process the group rule.
* "Paused". Stop processing the group rule.

Changing the value of the processing state doesn't change the members list of the group.

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

### -Visibility

This parameter determines the visibility of the group's content and members list.
This parameter can take one of the following values:

* "Public" - Anyone can view the contents of the group
* "Private" - Only members can view the content of the group
* "HiddenMembership" - Only members can view the content of the group and only members, owners, Global/Company Administrator, User Administrator and Helpdesk Administrators can view the members list of the group.

If no value is provided, the default value will be "Public".

Notes:

* This parameter is only valid for groups that have the groupType set to "Unified".
* If a group has this attribute set to "HiddenMembership", it can't be changed later.
* Anyone can join a group that has this attribute set to "Public". If the attribute is set to Private or HiddenMembership, only owner(s) can add new members to the group and requests to join the group need approval of the owner(s).

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

### -AssignedLabels

This parameter allows the assignment of sensitivity labels to groups. For more information on how sensitivity labels can be assigned to groups, refer to [Assign sensitivity labels](https://learn.microsoft.com/entra/identity/users/groups-dynamic-membership)

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AssignedLabel]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsAssignableToRole

Flag indicates whether group can be assigned to a role. This property can only be set at the time of group creation and can't be modified on an existing group.

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

### -ProxyAddresses

Sets the proxyAddresses attribute.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### None

## Outputs

### System.Object

## Notes

## Related links

[Add-EntraBetaAdministrativeUnitMember](Add-EntraBetaAdministrativeUnitMember.md)

[Get-EntraBetaAdministrativeUnitMember](Get-EntraBetaAdministrativeUnitMember.md)

[Remove-EntraBetaAdministrativeUnitMember](Remove-EntraBetaAdministrativeUnitMember.md)
