---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSPrivilegedRoleAssignment

## Synopsis
Get role assignments for a specific provider and resource

## Syntax

### GetQuery (Default)
```
Get-EntraBetaMSPrivilegedRoleAssignment -ResourceId <String> [-Top <Int32>] [-Filter <String>]
 -ProviderId <String> [<CommonParameters>]
```

### GetById
```
Get-EntraBetaMSPrivilegedRoleAssignment -Id <String> -ResourceId <String> -ProviderId <String>
 [<CommonParameters>]
```

## Description
Get role assignments for a specific provider and resource

## Examples

### Example 1
```
PS C:\> Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId AzureResources -ResourceId 3f5887ed-dd6e-4821-8bde-c813ec508cf9
```

Get all role assignments for a specific provider and resource

### Example 2
```
PS C:\> Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId AzureResources -ResourceId 3f5887ed-dd6e-4821-8bde-c813ec508cf9 -Id b83c177a-10e0-4eeb-8d0b-f3668fbf81fa
```

Get a role assignment for a specific provider and resource

## Parameters

### -Filter
The Odata filter

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

### -ProviderId
The unique identifier of the specific provider

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ResourceId
The unique identifier of the specific resource

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Id
The unique identifier of the specific role assignment

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

### -Top
The top count

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String
### System.Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]
## Outputs

### System.Object
## Notes

## Related LINKS
