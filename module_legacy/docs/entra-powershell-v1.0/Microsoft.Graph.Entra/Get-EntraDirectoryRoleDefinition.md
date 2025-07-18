---
title: Get-EntraDirectoryRoleDefinition
description: This article provides details on the Get-EntraDirectoryRoleDefinition command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraDirectoryRoleDefinition

schema: 2.0.0
---

# Get-EntraDirectoryRoleDefinition

## Synopsis

Gets information about role definitions in Microsoft Entra ID.

## Syntax

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

## Description

The `Get-EntraDirectoryRoleDefinition` cmdlet gets information about role definitions in Microsoft Entra ID. To get a role definition, specify the `UnifiedRoleDefinitionId` parameter. Specify the `SearchString` or `Filter` parameter to find particular role definition.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with one of the following permissions:

- microsoft.directory/roleAssignments/standard/read (least privileged)
- microsoft.directory/roleAssignments/allProperties/read
- microsoft.directory/roleAssignments/allProperties/allTasks

The least privileged roles for this operation, from least to most privileged, are:

- Directory Readers
- Global Reader
- Privileged Role Administrator

## Examples

### Example 1: Get all role definitions

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory','EntitlementManagement.Read.All'
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
Connect-Entra -Scopes 'RoleManagement.Read.Directory','EntitlementManagement.Read.All'
Get-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId '1a327991-10cb-4266-877a-998fb4df78ec'
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
Connect-Entra -Scopes 'RoleManagement.Read.Directory','EntitlementManagement.Read.All'
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
Connect-Entra -Scopes 'RoleManagement.Read.Directory','EntitlementManagement.Read.All'
Get-EntraDirectoryRoleDefinition -Top 2
```

```Output
DisplayName           Id                                   TemplateId                           Description                                                                       IsBuiltIn IsEnabled
-----------           --                                   ----------                           -----------                                                                       --------- ---------
Restricted Guest User 00aa00aa-bb11-cc22-dd33-44ee44ee44ee 2af84b1e-32c8-42b7-82bc-daa82404023b Restricted role for guest users. Can read a limited set of directory information. True      True
```

This command return top two the role definitions in Microsoft Entra DirectoryRoleId.

### Example 5: Filter role definitions by display name

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory','EntitlementManagement.Read.All'
Get-EntraDirectoryRoleDefinition -SearchString 'Global'
 ```

```Output
DisplayName           Id                                   TemplateId                           Description                                                                       IsBuiltIn IsEnabled
-----------           --                                   ----------                           -----------                                                                       --------- ---------
Global Administrator               00aa00aa-bb11-cc22-dd33-44ee44ee44ee 62e90394-69f5-4237-9190-012177145e10 Can manage all aspects of Microsoft Entra ID and Microsoft services that use Microsoft Entra identit…
Global Reader                      11bb11bb-cc22-dd33-ee44-55ff55ff55ff f2ef992c-3afb-46b9-b7cf-a126ee74c451 Can read everything that a Global Administrator can, but not update anything.
```

This command return all the role definitions containing the specified display name.

## Parameters

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
Aliases:

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

### String

## Outputs

## Notes

`Get-EntraRoleDefinition` is an alias for `Get-EntraDirectoryRoleDefintion`.

## Related Links

[New-EntraDirectoryRoleDefinition](New-EntraDirectoryRoleDefinition.md)

[Remove-EntraDirectoryRoleDefinition](Remove-EntraDirectoryRoleDefinition.md)

[Set-EntraDirectoryRoleDefinition](Set-EntraDirectoryRoleDefinition.md)
