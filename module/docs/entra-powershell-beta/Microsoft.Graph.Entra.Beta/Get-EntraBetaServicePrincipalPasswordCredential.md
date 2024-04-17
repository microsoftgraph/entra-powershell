---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaServicePrincipalPasswordCredential

## SYNOPSIS
Get credentials for a service principal.

## SYNTAX

```
Get-EntraBetaServicePrincipalPasswordCredential -ObjectId <String> [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaServicePrincipalPasswordCredential cmdlet gets the password credentials for a service principal in Azure Active Directory (AD).

## EXAMPLES

### Example 1: Retrieve the password credential of a service principal
```
PS C:\> $ServicePrincipalId = (Get-EntraBetaServicePrincipal -Top 1).ObjectId
PS C:\> Get-EntraBetaServicePrincipalPasswordCredential -ObjectId $ServicePrincipalId
```

The first command gets the ID of a service principal by using the Get-EntraBetaServicePrincipal (./Get-EntraBetaServicePrincipal.md)cmdlet. 
The command stores the ID in the $ServicePrincipalId variable.

The second command gets the password credential of a service principal identified by $ServicePrincipalId.

## PARAMETERS



### -ObjectId
Specifies the ID of the service principal for which to get password credentials.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaServicePrincipal]()

[New-EntraBetaServicePrincipalPasswordCredential]()

[Remove-EntraBetaServicePrincipalPasswordCredential]()

