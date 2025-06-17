---
title: Set-EntraPartnerInformation
description: This article provides details on the Set-EntraPartnerInformation command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraPartnerInformation

schema: 2.0.0
---

# Set-EntraPartnerInformation

## Synopsis

Sets company information for partners.

## Syntax

```powershell
Set-EntraPartnerInformation
 [-CompanyType <CompanyType>]
 [-PartnerCompanyName <String>]
 [-PartnerSupportTelephones <String[]>]
 [-PartnerSupportEmails <String[]>]
 [-PartnerCommerceUrl <String>]
 [-PartnerSupportUrl <String>]
 [-PartnerHelpUrl <String>]
 [-TenantId <Guid>]
 [<CommonParameters>]
```

## Description

The `Set-EntraPartnerInformation` cmdlet is used by partners to set partner-specific properties.

These properties can view by all tenants that the partner has access to.

## Examples

### Example 1: Update the help URL

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
Set-EntraPartnerInformation -PartnerHelpUrl 'http://www.help.contoso.com'
```

This example shows how to update the help URL.

### Example 2: Update the Support URL

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
Set-EntraPartnerInformation -PartnerSupportUrl 'http://www.test1.com'
```

This example shows how to update the support URL.

### Example 3: Update the Commerce URL

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
Set-EntraPartnerInformation -PartnerCommerceUrl 'http://www.test1.com'
```

This example shows how to update the commerce URL.

### Example 4: Update the SupportEmails

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
Set-EntraPartnerInformation -PartnerSupportEmails 'contoso@example.com'
```

This example shows how to update the support email addresses.

### Example 5: Update the SupportTelephones

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
$tenantId = (Get-EntraContext).TenantId
Set-EntraPartnerInformation -PartnerSupportTelephones '234234234' -TenantId $tenantId
```

This example shows how to update support telephone numbers.

## Parameters

### -PartnerCommerceUrl

Specifies the URL for the partner's commerce website.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PartnerHelpUrl

Specifies the URL for the partner's Help website.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PartnerSupportEmails

Specifies the support email address for the partner.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PartnerSupportTelephones

Specifies the support telephone numbers for the partner.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PartnerSupportUrl

Specifies the URL for the partner's support website.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TenantId

Specifies the unique ID of the tenant on which to perform the operation. This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CompanyType

Specifies the partner's company type.

```yaml
Type: CompanyType
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PartnerCompanyName

Specifies the partner's company name.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (<https://go.microsoft.com/fwlink/?LinkID=113216>).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraPartnerInformation](Get-EntraPartnerInformation.md)
