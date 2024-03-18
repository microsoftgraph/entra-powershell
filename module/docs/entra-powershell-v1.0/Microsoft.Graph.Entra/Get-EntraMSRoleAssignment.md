---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSRoleAssignment

## SYNOPSIS
Get a Microsoft Entra ID roleAssignment by id

## SYNTAX

### GetQuery (Default)
```
Get-EntraMSRoleAssignment [-Top <Int32>] [-All <Boolean>] [-Filter <String>] [<CommonParameters>]
```

### GetVague
```
Get-EntraMSRoleAssignment [-SearchString <String>] [-All <Boolean>] [<CommonParameters>]
```

### GetById
```
Get-EntraMSRoleAssignment -Id <String> [-All <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Get a Microsoft Entra ID roleAssignment object by id.
For more info see https://go.microsoft.com/fwlink/?linkid=2097519.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Id
The unique idenfier of a Microsoft Entra ID roleAssignment object.

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
Boolean to express that return all results from the server for the specific query

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

### -Top
The maximum number of records to return.

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
The oData v3.0 filter statement. 
Controls which objects are returned.

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
{{ Fill SearchString Description }}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### string
### bool?
### int?
### string
## OUTPUTS

### Microsoft.Open.MSGraph.Model.DirectoryRoleAssignment
## NOTES

## RELATED LINKS
