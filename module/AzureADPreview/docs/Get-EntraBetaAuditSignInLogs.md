---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaAuditSignInLogs

## SYNOPSIS
Get audit logs of signins

## SYNTAX

```
Get-EntraBetaAuditSignInLogs [-Top <Int32>] [-All <Boolean>] [-Filter <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaAuditSignInLogs cmdlet gets an Azure Active Directory sign in log.

## EXAMPLES

### Example 1: Get sign in logs after a certain date
```
PS C:\>Get-EntraBetaAuditSignInLogs -Filter "createdDateTime gt 2019-03-20"
```

This command gets all sign in logs on or after 3/20/2019

### Example 2: Get sign in logs for a user or application
```
PS C:\>Get-EntraBetaAuditSignInLogs -Filter "userPrincipalName eq 'bgates@microsoft.com'"
PS C:\>Get-EntraBetaAuditSignInLogs -Filter "userDisplayName eq 'Paul Allen'"
PS C:\>Get-EntraBetaAuditSignInLogs -Filter "appId eq 'de8bc8b5-d9f9-48b1-a8ad-b748da725064'"
PS C:\>Get-EntraBetaAuditSignInLogs -Filter "appDisplayName eq 'Microsoft'"
```

These commands are different ways to get all sign in logs for a certain user or application

### Example 3: Get sign in logs from a certain location
```
PS C:\>Get-EntraBetaAuditSignInLogs -Filter "location/city eq 'Redmond' and location/state eq 'Washington' and location/countryOrRegion eq 'US'"
```

This command shows how to get audit logs by location

### Example 4: Get all sign in logs with a given status
```
PS C:\>Get-EntraBetaAuditSignInLogs -Filter "status/errorCode eq 0 -All $true"
PS C:\>Get-EntraBetaAuditSignInLogs -Filter "status/errorCode ne 0"
```

These commands show how to get sign in logs for successes (eq 0) and failures (ne 0)

## PARAMETERS

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
Parameter Sets: (All)
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
Parameter Sets: (All)
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
