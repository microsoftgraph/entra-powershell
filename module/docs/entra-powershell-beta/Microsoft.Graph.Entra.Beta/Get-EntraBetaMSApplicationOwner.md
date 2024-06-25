---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSApplicationOwner

## Synopsis
Retrieves the list of owners for an application object.

## Syntax

```
Get-EntraBetaMSApplicationOwner [-ObjectId <String>] [-All] [-Top <Int32>] [<CommonParameters>]
```

## Description
Retrieves the list of owners for an application object.

## Examples

### Example 1: Get the owner of an application
```
PS C:\>Get-EntraBetaMSApplicationOwner -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Top 1

          ObjectId                             ObjectType
          --------                             ----------
          c13dd34a-492b-4561-b171-40fcce2916c5 User
```

This command gets the owner of an application.

### Example 1: Get the owners of an application
```
PS C:\>Get-EntraBetaMSApplicationOwner -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -All

          ObjectId                             ObjectType
          --------                             ----------
          c13dd34a-492b-4561-b171-40fcce2916c5 User
```

This command gets the owners of an application.

## Parameters

### -ObjectId
Specifes the ID of an application in Azure Active Directory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: (All)
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

### bool?
### int?
### string
## Outputs

### Microsoft.Open.MSGraph.Model.GetDirectoryObjectsResponse
## Notes

## Related LINKS

[Add-EntraBetaMSApplicationOwner]()

[Remove-EntraBetaMSApplicationOwner]()

