---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaGroupLifecyclePolicy

## SYNOPSIS
Retrieves the properties and relationships of a groupLifecyclePolicies object in Azure Active Directory.
If you specify no parameters, this cmdlet gets all groupLifecyclePolicies.

## SYNTAX

### GetQuery (Default)
```
Get-EntraBetaGroupLifecyclePolicy [<CommonParameters>]
```

### GetById
```
Get-EntraBetaGroupLifecyclePolicy -Id <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaGroupLifecyclePolicy command retrieves the properties and relationships of a groupLifecyclePolicies object in Azure Active Directory.
If you specify no parameters, this cmdlet gets all groupLifecyclePolicies.

## EXAMPLES

### Example 1
```
PS C:\> Get-EntraBetaGroupLifecyclePolicy
```

This command retrieves the group expiration settings configured for the tenant

## PARAMETERS

### -Id
Specifies the ID of a groupLifecyclePolicies object in Azure Active Directory

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
