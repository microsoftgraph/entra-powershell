---
external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaPartnerInformation

## SYNOPSIS
Retrieves company-level information for partners.

## SYNTAX

### GetQuery (Default)
```
Get-EntraBetaPartnerInformation [<CommonParameters>]
```

### GetById
```
Get-EntraBetaPartnerInformation [-TenantId <Guid>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaPartnerInformation cmdlet is used to retrieve partner-specific information.
This cmdlet should only be used for partner tenants.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -TenantId
The unique ID of the tenant to perform the operation on.
If this is not provided, then the value will default to the tenant of the current user.
This parameter is only applicable to partner users.

```yaml
Type: Guid
Parameter Sets: GetById
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### The cmdlet will return the following company level information:
### - CompanyType: The type of this company (can be partner or regular tenant)
### - DapEnabled: Flag to determine if the partner has delegated admin privileges.
### - PartnerCompanyName: The name of the company
### - PartnerSupportTelephones: Support Telephone numbers for the partner.
### - PartnerSupportEmails: Support E-Mail address for the partner.
### - PartnerCommerceUrl: URL for the partner's commerce web site.
### - PartnerSupportUrl: URL for the Partner's support website.
### - PartnerHelpUrl: URL for the partner's help web site.
## NOTES

## RELATED LINKS
