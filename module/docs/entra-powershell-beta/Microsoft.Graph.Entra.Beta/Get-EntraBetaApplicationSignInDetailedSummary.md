---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaApplicationSignInDetailedSummary

## Synopsis
Get detailed sign in summaries

## Syntax

```
Get-EntraBetaApplicationSignInDetailedSummary [-Top <Int32>] [-Filter <String>] [<CommonParameters>]
```

## Description
The Get-EntraBetaApplicationSignInDetailedSummary cmdlet gets Azure Active Directory sign ins, grouped by application, date, and sign in status.

## Examples

### Example 1: Get sign in detailed summary by application and date
```
PS C:\>Get-EntraBetaApplicationSignInDetailedSummary -Filter "appDisplayName eq 'Azure Portal' AND aggregatedEventDateTime gt 2019-05-01 AND aggregatedEventDateTime lt 2019-06-01"
```

This command gets all sign ins to Azure Portal for the month of May.

### Example 2: Get certain sign in failures
```
PS C:\>Get-EntraBetaApplicationSignInDetailedSummary -Filter "status/errorCode eq 0 50089"
```

This command gets all sign ins that failed with 50089 code for "FailureReason: Flow token expired".

## Parameters

### -Top
The maximum number of records to return.

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

### -Filter
The OData V4.0 filter statement. 
Controls which objects are returned.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

### Microsoft.Online.Administration.GetApplicationSignInDetailedSummaryObjectsResponse
## Notes
## Related Links
