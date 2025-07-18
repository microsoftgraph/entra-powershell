---
description: This article provides details on the Get-EntraDirectoryRoleDefinition command.
external help file: Microsoft.Entra.Governance-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraDirectoryRoleDefinition
schema: 2.0.0
title: Get-EntraDirectoryRoleDefinition
---

# Get-EntraDirectoryRoleDefinition

## SYNOPSIS

Gets information about role definitions in Microsoft Entra ID.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraDirectoryRoleDefinition
 [-All]
 [-Top <Int32>]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraDirectoryRoleDefinition
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraDirectoryRoleDefinition
 -UnifiedRoleDefinitionId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraDirectoryRoleDefinition` cmdlet gets information about role definitions in Microsoft Entra ID. To get a role definition, specify the `UnifiedRoleDefinitionId` parameter. Specify the `SearchString` or `Filter` parameter to find particular role definition.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with one of the following permissions:

- microsoft.directory/roleAssignments/standard/read (least privileged)
- microsoft.directory/roleAssignments/allProperties/read
- microsoft.directory/roleAssignments/allProperties/allTasks

The least privileged roles for this operation, from least to most privileged, are:

- Directory Readers
- Global Reader
- Privileged Role Administrator

## EXAMPLES

### Example 1: Get all role definitions

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory', 'EntitlementManagement.Read.All'
Get-EntraDirectoryRoleDefinition
```

```Output
DisplayName                                   Id                                   TemplateId                           Description
-----------                                   --                                   ----------                           -----------
Guest User                                    10dae51f-b6af-4016-8d66-8c2a99b929b3 10dae51f-b6af-4016-8d66-8c2a99b929b3 Default role for guest users. Can read a limited set of directory information.
Restricted Guest User                         2af84b1e-32c8-42b7-82bc-daa82404023b 2af84b1e-32c8-42b7-82bc-daa82404023b Restricted role for guest users. Can read a limited set of directory information.
```

This command returns all the role definitions present.

### Example 2: Get a role definition by UnifiedRoleDefinitionId

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory', 'EntitlementManagement.Read.All'
$role = Get-EntraDirectoryRoleDefinition -Filter "DisplayName eq 'Helpdesk Administrator'"
Get-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId $role.Id
```

```Output
DisplayName                                   Id                                   TemplateId                           Description
-----------                                   --                                   ----------                           -----------
Restricted Guest User                         2af84b1e-32c8-42b7-82bc-daa82404023b 2af84b1e-32c8-42b7-82bc-daa82404023b Restricted role for guest users. Can read a limited set of directory information.
```

This command returns a specified role definition.

- `-UnifiedRoleDefinitionId` parameter specifies the roleDefinition object ID.

### Example 3: Filter role definitions by display name

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory', 'EntitlementManagement.Read.All'
Get-EntraDirectoryRoleDefinition -Filter "startsWith(displayName, 'Restricted')"
```

```Output
DisplayName                                   Id                                   TemplateId                           Description
-----------                                   --                                   ----------                           -----------
Restricted Guest User                         2af84b1e-32c8-42b7-82bc-daa82404023b 2af84b1e-32c8-42b7-82bc-daa82404023b Restricted role for guest users. Can read a limited set of directory information.
```

This command return all the role definitions containing the specified display name.

### Example 4: Get top two role definition

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory', 'EntitlementManagement.Read.All'
Get-EntraDirectoryRoleDefinition -Top 2
```

```Output
DisplayName           Id                                   TemplateId                           Description                                                                       IsBuiltIn IsEnabled
-----------           --                                   ----------                           -----------                                                                       --------- ---------
Restricted Guest User 00aa00aa-bb11-cc22-dd33-44ee44ee44ee 2af84b1e-32c8-42b7-82bc-daa82404023b Restricted role for guest users. Can read a limited set of directory information. True      True
```

This command return top two the role definitions in Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

### Example 5: Filter role definitions by display name

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory', 'EntitlementManagement.Read.All'
Get-EntraDirectoryRoleDefinition -SearchString 'Global'
```

```Output
DisplayName                        Id                                   TemplateId                           Description                                                                                                                                                           IsBu
                                                                                                                                                                                                                                                                                   iltI
                                                                                                                                                                                                                                                                                   n
-----------                        --                                   ----------                           -----------                                                                                                                                                           ----
Global Administrator               62e90394-69f5-4237-9190-012177145e10 62e90394-69f5-4237-9190-012177145e10 Can manage all aspects of Microsoft Entra ID and Microsoft services that use Microsoft Entra identities.                                                              True
Global Reader                      f2ef992c-3afb-46b9-b7cf-a126ee74c451 f2ef992c-3afb-46b9-b7cf-a126ee74c451 Can read everything that a Global Administrator can, but not update anything.                                                                                         True
```

This command return all the role definitions containing the specified display name.

## PARAMETERS

### -UnifiedRoleDefinitionId

Specifies the UnifiedRoleDefinitionId of the role definition.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records that this cmdlet gets. The default value is 100.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases: Limit

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter

Specifies an OData v4.0 filter string to match a set of role definitions.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SearchString

Specifies a search string.

```yaml
Type: System.String
Parameter Sets: GetVague
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String

## OUTPUTS

## NOTES

`Get-EntraRoleDefinition` is an alias for `Get-EntraDirectoryRoleDefintion`.

## RELATED LINKS

[New-EntraDirectoryRoleDefinition](New-EntraDirectoryRoleDefinition.md)

[Remove-EntraDirectoryRoleDefinition](Remove-EntraDirectoryRoleDefinition.md)

[Set-EntraDirectoryRoleDefinition](Set-EntraDirectoryRoleDefinition.md)
