---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# New-EntraBetaMSRoleDefinition

## SYNOPSIS
Create a new Azure Active Directory roleDefinition.

## SYNTAX

```
New-EntraBetaMSRoleDefinition -IsEnabled <Boolean> [-Description <String>]
 [-InheritsPermissionsFrom <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.DirectoryRoleDefinition]>]
 [-Version <String>] [-ResourceScopes <System.Collections.Generic.List`1[System.String]>]
 -RolePermissions <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RolePermission]>
 [-TemplateId <String>] -DisplayName <String> [<CommonParameters>]
```

## DESCRIPTION
Create a new Azure Active Directory roleDefinition object.
For more info see https://go.microsoft.com/fwlink/?linkid=2097519.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Description
{{ Fill Description Description }}

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
{{ Fill DisplayName Description }}

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

### -InheritsPermissionsFrom
{{ Fill InheritsPermissionsFrom Description }}

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.DirectoryRoleDefinition]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsEnabled
{{ Fill IsEnabled Description }}

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

### -ResourceScopes
{{ Fill ResourceScopes Description }}

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

### -RolePermissions
{{ Fill RolePermissions Description }}

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.RolePermission]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateId
{{ Fill TemplateId Description }}

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

### -Version
{{ Fill Version Description }}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Open.MSGraph.Model.DirectoryRoleDefinition
## NOTES

## RELATED LINKS
