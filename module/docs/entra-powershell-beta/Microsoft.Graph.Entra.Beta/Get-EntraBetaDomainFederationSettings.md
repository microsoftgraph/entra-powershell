---
external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaDomainFederationSettings

schema: 2.0.0
---

# Get-EntraBetaDomainFederationSettings

## Synopsis
Retrieves settings for a federated domain.

## Syntax

```
Get-EntraBetaDomainFederationSettings [-DomainName] <String> [[-TenantId] <Guid>] [<CommonParameters>]
```

## Description
The Get-EntraBetaDomainFederationSettings cmdlet gets key settings from Microsoft Azure Active Directory.
Use the Get-EntraFederationProperty cmdlet to get settings for both Microsoft Azure Active Directory and the Active Directory Federation Services server.

## Examples

### Example 1
```
Get-EntraBetaDomainFederationSettings -DomainName contoso.com
    
    Returns the federation settings for contoso.com.
    Description
    
    -----------
    
    Returns the federation settings for contoso.com.
```

## Parameters

### -DomainName
The fully qualified domain name to retrieve.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TenantId
The unique ID of the tenant to perform the operation on.
If this is not provided then the value will default to the tenant of the current user.
This parameter is only applicable to partner users.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

### Microsoft.Online.Administration.DomainFederationSettings
### This cmdlet returns the following settings:
###         ActiveLogOnUri
###         FederationBrandName
###         IssuerUri
###         LogOffUri
###         MetadataExchangeUri
###         NextSigningCertificate
###         PassiveLogOnUri
###         SigningCertificate
## Notes

## Related Links
