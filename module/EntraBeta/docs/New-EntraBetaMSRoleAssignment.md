---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# New-EntraBetaMSRoleAssignment

## SYNOPSIS
Create a new Azure Active Directory roleAssignment.

## SYNTAX

```
New-EntraBetaMSRoleAssignment -RoleDefinitionId <String> -DirectoryScopeId <String> -PrincipalId <String>
 [<CommonParameters>]
```

## DESCRIPTION
Create a new Azure Active Directory roleAssignment object.
For more info see https://go.microsoft.com/fwlink/?linkid=2097519.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -DirectoryScopeId
{{ Fill DirectoryScopeId Description }}

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

### -PrincipalId
{{ Fill PrincipalId Description }}

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

### -RoleDefinitionId
{{ Fill RoleDefinitionId Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Open.MSGraph.Model.DirectoryRoleAssignment
## NOTES

## RELATED LINKS
