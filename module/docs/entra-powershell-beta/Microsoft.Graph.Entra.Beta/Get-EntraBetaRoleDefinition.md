---
title: Get-EntraBetaRoleDefinition
description: This article provides details on the Get-EntraBetaRoleDefinition command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaRoleDefinition

schema: 2.0.0
---

# Get-EntraBetaRoleDefinition

## Synopsis
Gets information about role definitions in Microsoft Entra ID.

## Syntax

### GetQuery (Default)
```powershell
Get-EntraBetaRoleDefinition 
 [-All] 
 [-Top <Int32>] 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetVague
```powershell
Get-EntraBetaRoleDefinition 
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraBetaRoleDefinition 
 -Id <String> 
 [-All] 
 [<CommonParameters>]
```

## Description
The Get-EntraBetaRoleDefinition cmdlet gets information about role definitions in Microsoft Entra ID. To get a role definition, specify the Id parameter. Specify the SearchString or Filter parameter to find particular role definition.

## Examples

### Example 1: Get all role definitions
```powershell
PS C:\> Get-EntraBetaRoleDefinition
```

```output
Id              : 690e93e9-da28-4b25-9d0d-2f0b4e6b2ff9
OdataType       :
Description     : SampleRoleDefinition1.
DisplayName     : SampleRoleDef
IsBuiltIn       : False
ResourceScopes  : {/}
IsEnabled       : True
RolePermissions : {class RolePermission {
                  AllowedResourceActions:
                  microsoft.directory/applications/create
                    Condition:
                  }
                  }

Id              : 1a327991-10cb-4266-877a-998fb4df78ec
OdataType       :
Description     :
DisplayName     : SampleRoleDefinition2.
IsBuiltIn       : False
ResourceScopes  : {/}
IsEnabled       : True
RolePermissions : {class RolePermission {
                  AllowedResourceActions:
                  microsoft.directory/applications/create
                    Condition:
                  }
                  }
TemplateId      : 332a8659-25b8-4b3e-b545-38b331c48b2b
Version         :
```

This command returns all the role definitions present.

### Example 2: Get a role definition by ID
```powershell
PS C:\> Get-EntraBetaRoleDefinition -Id 1a327991-10cb-4266-877a-998fb4df78ec
```

```output
Id              : 1a327991-10cb-4266-877a-998fb4df78ec
OdataType       :
Description     :
DisplayName     : SampleRoleDefinition2.
IsBuiltIn       : False
ResourceScopes  : {/}
IsEnabled       : True
RolePermissions : {class RolePermission {
                  AllowedResourceActions:
                  microsoft.directory/applications/create
                    Condition:
                  }
                  }
TemplateId      : 332a8659-25b8-4b3e-b545-38b331c48b2b
Version         :
```

This command returns a specified role definition.

### Example 3: Filter role definitions by display name
```powershell
PS C:\> Get-EntraBetaRoleDefinition -Filter "startswith(displayName, 'Sample')"
```

```output
Id              : 690e93e9-da28-4b25-9d0d-2f0b4e6b2ff9
OdataType       :
Description     : SampleRoleDefinition1.
DisplayName     : SampleRoleDef
IsBuiltIn       : False
ResourceScopes  : {/}
IsEnabled       : True
RolePermissions : {class RolePermission {
                  AllowedResourceActions:
                  microsoft.directory/applications/create
                    Condition:
                  }
                  }
Id              : 1a327991-10cb-4266-877a-998fb4df78ec
OdataType       :
Description     :
DisplayName     : SampleRoleDefinition2.
IsBuiltIn       : False
ResourceScopes  : {/}
IsEnabled       : True
RolePermissions : {class RolePermission {
                  AllowedResourceActions:
                  microsoft.directory/applications/create
                    Condition:
                  }
                  }
TemplateId      : 332a8659-25b8-4b3e-b545-38b331c48b2b
Version         :
```

This command return all the role definitions containing the specified display name.

## Parameters

### -Id
Specifies the ID of the role definition.

```yaml
Type: String
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
Type: SwitchParameter
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
Type: Int32
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
Type: String
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
Type: String
Parameter Sets: GetVague
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### String
### Bool?
### Int?
### String
## Outputs

### Microsoft.Open.MSGraph.Model.DirectoryRoleDefinition

## RELATED LINKS