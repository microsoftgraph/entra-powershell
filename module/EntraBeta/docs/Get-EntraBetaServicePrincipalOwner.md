---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaServicePrincipalOwner

## SYNOPSIS
Get the owner of a service principal.

## SYNTAX

```
Get-EntraBetaServicePrincipalOwner [-Top <Int32>] -ObjectId <String> [-All <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaServicePrincipalOwner cmdlet gets the owners of a service principal in Azure Active Directory (AD).

## EXAMPLES

### Example 1: Retrieve the owner of a service principal
```
PS C:\> $ServicePrincipalId = (Get-EntraBetaServicePrincipal -Top 1).ObjectId
PS C:\> Get-EntraBetaServicePrincipalOwner -ObjectId $ServicePrincipalId
```

The first command gets the ID of a service principal by using the Get-EntraBetaServicePrincipal (./Get-EntraBetaServicePrincipal.md)cmdlet. 
The command stores the ID in the $ServicePrincipalId variable.

The second command gets the owner of a service principal identified by $ServicePrincipalId.

## PARAMETERS

### -All
If true, return all service principal owners for this service principal.
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

### -ObjectId
Specifies the ID of a service principal in Azure AD.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaServicePrincipalOwner]()

[Get-EntraBetaServicePrincipal]()

[Remove-EntraBetaServicePrincipalOwner]()

