---
Title: Get-EntraRoleDefinition
Description: This article provides details on the Get-EntraRoleDefinition command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG

External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Get-EntraRoleDefinition

## Synopsis

Gets information about role definitions in Microsoft Entra ID.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraRoleDefinition 
 [-All] 
 [-Top <Int32>] 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraRoleDefinition 
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraRoleDefinition 
 -Id <String> 
 [-All] 
 [<CommonParameters>]
```

## Description

The `Get-EntraRoleDefinition` cmdlet gets information about role definitions in Microsoft Entra ID. To get a role definition, specify the `Id` parameter. Specify the `SearchString` or `Filter` parameter to find particular role definition.

## Examples

### Example 1: Get all role definitions

```powershell
 Connect-Entra -Scopes 'RoleManagement.Read.Directory' #For the directory (Microsoft Entra ID) provider
 Connect-Entra -Scopes 'EntitlementManagement.Read.All' #For the entitlement management provider
 Get-EntraRoleDefinition
```

```Output
DisplayName                                   Id                                   TemplateId                           Description
-----------                                   --                                   ----------                           -----------
Guest User                                    10dae51f-b6af-4016-8d66-8c2a99b929b3 10dae51f-b6af-4016-8d66-8c2a99b929b3 Default role for guest users. Can read a limited set of directory information.
Restricted Guest User                         2af84b1e-32c8-42b7-82bc-daa82404023b 2af84b1e-32c8-42b7-82bc-daa82404023b Restricted role for guest users. Can read a limited set of directory information.
```

This command returns all the role definitions present.

### Example 2: Get a role definition by ID

```powershell
 Connect-Entra -Scopes 'RoleManagement.Read.Directory' #For the directory (Microsoft Entra ID) provider
 Connect-Entra -Scopes 'EntitlementManagement.Read.All' #For the entitlement management provider
 Get-EntraRoleDefinition -Id 1a327991-10cb-4266-877a-998fb4df78ec
```

```Output
DisplayName                                   Id                                   TemplateId                           Description
-----------                                   --                                   ----------                           -----------
Restricted Guest User                         2af84b1e-32c8-42b7-82bc-daa82404023b 2af84b1e-32c8-42b7-82bc-daa82404023b Restricted role for guest users. Can read a limited set of directory information.
```

This command returns a specified role definition.

### Example 3: Filter role definitions by display name

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory' #For the directory (Microsoft Entra ID) provider
 Connect-Entra -Scopes 'EntitlementManagement.Read.All' #For the entitlement management provider
 Get-EntraRoleDefinition -Filter "startsWith(displayName, 'Restricted')"
```

```Output
DisplayName                                   Id                                   TemplateId                           Description
-----------                                   --                                   ----------                           -----------
Restricted Guest User                         2af84b1e-32c8-42b7-82bc-daa82404023b 2af84b1e-32c8-42b7-82bc-daa82404023b Restricted role for guest users. Can read a limited set of directory information.
```

This command return all the role definitions containing the specified display name.

## Parameters

### -Id

Specifies the ID of the role definition.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

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

Specifies an oData v3.0 filter string to match a set of role definitions.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### String

## Outputs

### Microsoft.Open.MSGraph.Model.DirectoryRoleDefinition

## Related Links
