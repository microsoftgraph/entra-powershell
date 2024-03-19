---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraApplication

## SYNOPSIS
Gets an application.

## SYNTAX

### GetQuery (Default)
```
Get-EntraApplication [-Filter <String>] [-All <Boolean>] [-Top <Int32>] [<CommonParameters>]
```

### GetVague
```
Get-EntraApplication [-SearchString <String>] [-All <Boolean>] [<CommonParameters>]
```

### GetById
```
Get-EntraApplication -ObjectId <String> [-All <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraApplication cmdlet gets a Microsoft Entra ID application.

## EXAMPLES

### Example 1: Get an application by display name
```
PS C:\>Get-EntraApplication -Filter "DisplayName eq 'TestName'"

ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
3ddd22e7-a150-4bb3-b100-e410dea1cb84 36ee4c6c-0812-40a2-b820-b22ebd02bce3 TestName
```

This command gets an application by its display name.

### Example 2: Get an application by ID
```
PS C:\>Get-EntraApplication -Filter "AppId eq 'ed192e92-84d4-4baf-997d-1e190a81f28e'"
```

This command gets an application by its ID.

Output:

ObjectId                             AppId                                DisplayName     --------                             -----                                -----------
ed192e92-84d4-4baf-997d-1e190a81f28e 36ee4c6c-0812-40a2-b820-b22ebd02bce3 MyNewApp

### Retrieve an application by identifierUris
```
Get-EntraApplication -Filter "identifierUris/any(uri:uri eq 'http://wingtips.wingtiptoysonline.com')"
```

## PARAMETERS

### -All
If true, return all applications.
If false, return the number of objects specified by the Top parameter

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter
Specifies an oData v3.0 filter statement.
This parameter controls which objects are returned.

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

### -ObjectId
Specifies the ID of an application in Microsoft Entra ID.

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

### -Top
Specifies the maximum number of records to return.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraApplication]()

[Remove-EntraApplication]()

[Set-EntraApplication]()

