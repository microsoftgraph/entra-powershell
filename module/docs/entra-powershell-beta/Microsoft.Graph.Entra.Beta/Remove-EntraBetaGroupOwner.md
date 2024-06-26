---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaGroupOwner

## Synopsis
removes an owner from a group.

## Syntax

```
Remove-EntraBetaGroupOwner -OwnerId <String> -ObjectId <String> [<CommonParameters>]
```

## Description
the Remove-EntraBetaGroupOwner cmdlet removes an owner from a group in Azure Active Directory (AD).

## Examples

### Example 1: Remove an owner
```
PS C:\>Remove-EntraBetaGroupOwner -ObjectId "62438306-7c37-4638-a72d-0ee8d9217680" -OwnerId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
```

## Parameters


### -ObjectId
Specifies the ID of a group in Azure AD.

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

### -OwnerId
Specifies the ID of an owner.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraBetaGroupOwner]()

[Get-EntraBetaGroupOwner]()

