---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaApplicationSignInSummary

schema: 2.0.0
---

# Get-EntraBetaApplicationSignInSummary

## Synopsis
Get signin summary by last number of days

## Syntax

```
Get-EntraBetaApplicationSignInSummary -Days <Int32> [-Top <Int32>] [-Filter <String>] [<CommonParameters>]
```

## Description
The Get-EntraBetaApplicationSignInSummary cmdlet gets sign in summaries for the last 7 or 30 days.

## Examples

### Example 1: Get sign in summary by application for the last week
```
PS C:\>Get-EntraBetaApplicationSignInSummary -Days 7 -Filter "appDisplayName eq 'Graph Explorer'"
```

This command gets a summary of all sign ins to Graph Explorer for the last 7 days.

### Example 2: Get sign in summaries for the last month
```
PS C:\>Get-EntraBetaApplicationSignInSummary -Days 30
```

This command gets summaries for all sign ins from the past 30 days.

## Parameters

### -Days
Number of past days summary will contain.
Valid values are 7 and 30

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter
{{ Fill Filter Description }}

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

### -Top
{{ Fill Top Description }}

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

## Outputs

### Microsoft.Online.Administration.GetApplicationSignInSummaryObjectsResponse
## Notes
## Related Links
