---
Title: New-EntraBetaAdministrativeUnit
Description: This article provides details on the New-EntraBetaAdministrativeUnit command.

Ms.service: active-directory
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG

External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# New-EntraBetaAdministrativeUnit

## Synopsis
Creates an administrative unit.

## Syntax

```powershell
New-EntraBetaAdministrativeUnit 
    -DisplayName <String>
    [-MembershipType <String>] 
    [-Description <String>] 
    [-MembershipRule <String>] 
    [-IsMemberManagementRestricted <Boolean>] 
    [-MembershipRuleProcessingState <String>]
 [<CommonParameters>]
```

## Description
The **New-EntraBetaAdministrativeUnit** cmdlet creates an administrative unit in Microsoft Entra ID.

## Examples

### Example 1: Create an administrative unit
```powershell
PS C:\> New-EntraBetaAdministrativeUnit -DisplayName "TestAU"
```

```output
DeletedDateTime Id                                   Description DisplayName IsMemberManagementRestricted Visibility
--------------- --                                   ----------- ----------- ---------------------------- ----------
                a30efb43-195c-4544-a754-fcd6df695020             TestAU      False
```

This command creates an administrative unit.

### Example 2: Create an administrative unit using '-Description' parameter
```powershell
PS C:\> New-EntraBetaAdministrativeUnit -DisplayName "test111" -Description "test111"
```

```output
DeletedDateTime Id                                   Description DisplayName IsMemberManagementRestricted Visibility
--------------- --                                   ----------- ----------- ---------------------------- ----------
                a30efb43-195c-4544-a754-fcd6df695020 test111     test111     False
```

### Example 3: Create an administrative unit using '-IsMemberManagementRestricted' parameter
```powershell
PS C:\> New-EntraBetaAdministrativeUnit -DisplayName "test111" -IsMemberManagementRestricted $true
```

```output
DeletedDateTime Id                                   Description DisplayName IsMemberManagementRestricted Visibility
--------------- --                                   ----------- ----------- ---------------------------- ----------
                a30efb43-195c-4544-a754-fcd6df695020             test111     True
```

This command creates an administrative unit.

## Parameters

### -Description
Specifies a description for the new administrative unit.

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
Specifies the display name of the new administrative unit.

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

### -IsMemberManagementRestricted
Indicates whether the management rights on resources in the administrative units should be restricted to ONLY the administrators scoped on the administrative unit object.
If no value is specified, it defaults to false.

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

### -MembershipRule
Specifies the membership rule for a dynamic administrative unit.
For more information about the rules that you can use for dynamic administrative units and dynamic groups, see [Using attributes to create advanced rules](https://azure.microsoft.com/documentation/articles/active-directory-accessmanagement-groups-with-advanced-rules/).

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

### -MembershipRuleProcessingState
Specifies the rule processing state. The acceptable values for this parameter are:
- "On". Process the group rule.
- "Paused". Stop processing the group rule.
Changing the value of the processing state doesn't change the members list of the administrative unit.

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

### -MembershipType
Specifies whether the membership of this administrative unit is controlled dynamically or by manual assignment.
The acceptable values for this parameter are:
- Assigned
- Dynamic

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

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaAdministrativeUnit](Get-EntraBetaAdministrativeUnit.md)

[Remove-EntraBetaAdministrativeUnit](Remove-EntraBetaAdministrativeUnit.md)

[Set-EntraBetaAdministrativeUnit](Set-EntraBetaAdministrativeUnit.md)
