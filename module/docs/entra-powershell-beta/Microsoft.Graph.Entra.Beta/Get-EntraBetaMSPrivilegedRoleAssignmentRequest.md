---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSPrivilegedRoleAssignmentRequest

## Synopsis
Get role assignment request for a specific resource

## Syntax

### GetQuery (Default)
```
Get-EntraBetaMSPrivilegedRoleAssignmentRequest [-Filter <String>] [-Top <Int32>] -ProviderId <String>
 [<CommonParameters>]
```

### GetById
```
Get-EntraBetaMSPrivilegedRoleAssignmentRequest -Id <String> -ProviderId <String> [<CommonParameters>]
```

## Description
Get role assignment request for a specific resource

## Examples

### Example 1
```
PS C:\> Get-EntraBetaMSPrivilegedRoleAssignmentRequest -ProviderId AzureResources -Filter "ResourceId eq 'e5e7d29d-5465-45ac-885f-4716a5ee74b5'"
```

Get all role assigment requests for a specific provider and resource

### Example 2
```
PS C:\> Get-EntraBetaMSPrivilegedRoleAssignmentRequest -ProviderId AzureResources -Id 247438d7-fc8d-4354-a737-4898a4019a95
```

Get a role assigment requests for a specific provider and Id

## Parameters

### -Id
The unique identifier of the specific role assignment request

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

### -Filter
The Odata query

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
