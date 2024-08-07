---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaDomainVerificationDnsRecord

schema: 2.0.0
---

# Get-EntraBetaDomainVerificationDnsRecord

## Synopsis
Retrieve the domain verification DNS record for a domain

## Syntax

```powershell
Get-EntraBetaDomainVerificationDnsRecord
 -Name <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description
Gets the domain's verification records from the verificationDnsRecords navigation property. 
You can't use the domain with your Azure AD tenant until you have successfully verified that you own the domain.
To verify the ownership of the domain, you need to first retrieve a set of domain verification records which you need to add to the zone file of the domain.

## Examples

### Example 1
```
PS C:\WINDOWS\system32> Get-EntraBetaDomainVerificationDnsRecord -Name drumkit.onmicrosoft.com

DnsRecordId                          Label                   SupportedService Ttl
-----------                          -----                   ---------------- ---
aceff52c-06a5-447f-ac5f-256ad243cc5c drumkit.onmicrosoft.com Email            3600
5fbde38c-0865-497f-82b1-126f596bcee9 drumkit.onmicrosoft.com Email            3600
```

This example shows how to retrieve the domain verification DNS records for the given domain name

## Parameters

### -Name
The domain name for which the domain verification DNS records are to be retrieved

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

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String
## Outputs

### System.Object
## Notes

## Related Links
