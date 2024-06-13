---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Add-EntraBetaMSApplicationOwner

## Synopsis
Adds an owner for an application object.

## Syntax

```
Add-EntraBetaMSApplicationOwner -ObjectId <String> -RefObjectId <String> [<CommonParameters>]
```

## Description
Adds an owner for an application object.

## Examples

### Example 1: Add an owner to an application
```
PS C:\>Add-EntraBetaMSApplicationOwner -ObjectId 3ddd22e7-a150-4bb3-b100-e410dea1cb84 -RefObjectId c13dd34a-492b-4561-b171-40fcce2916c5
```

This command adds an owner to an application.

## Parameters

### -ObjectId
The unique identifier of the object specific Azure Active Directory object

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

### -RefObjectId
The unique identifier of the specific Azure Active Directory object that will be assigned as owner/manager/member

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

### string
## Outputs

## Notes

## Related LINKS

[Get-EntraBetaMSApplicationOwner]()

[Remove-EntraBetaMSApplicationOwner]()

