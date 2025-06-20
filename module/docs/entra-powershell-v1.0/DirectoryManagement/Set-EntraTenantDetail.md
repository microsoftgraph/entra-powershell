---
author: msewaweru
description: This article provides details on the Set-EntraTenantDetail command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraTenantDetail
schema: 2.0.0
title: Set-EntraTenantDetail
---

# Set-EntraTenantDetail

## Synopsis

Set contact details for a tenant.

## Syntax

```powershell
Set-EntraTenantDetail
 [-PrivacyProfile <PrivacyProfile>]
 [-MarketingNotificationEmails <System.Collections.Generic.List`1[System.String]>]
 [-TechnicalNotificationMails <System.Collections.Generic.List`1[System.String]>]
 [-SecurityComplianceNotificationMails <System.Collections.Generic.List`1[System.String]>]
 [-SecurityComplianceNotificationPhones <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## Description

This cmdlet is used to set various contact details for a tenant.

For delegated scenarios, the signed-in user must have at least one of the following Microsoft Entra roles.

- Application Administrator
- Cloud Application Administrator
- Privileged Role Administrator
- User Administrator
- Helpdesk Administrator

## Examples

### Example 1: Set contact details for a tenant

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
$params = @{
    MarketingNotificationEmails = @('amy@contoso.com', 'henry@contoso.com')
    SecurityComplianceNotificationMails = @('john@contoso.com', 'mary@contoso.com')
    SecurityComplianceNotificationPhones = @('1-555-625-9999', '1-555-233-5544')
    TechnicalNotificationMails = 'peter@contoso.com'
}

Set-EntraTenantDetail @params
```

This example demonstrates how to set various contact details for a tenant.

- `-MarketingNotificationEmails` parameter indicates the email addresses that are used to send marketing notification emails.
- `-SecurityComplianceNotificationMails` parameter indicates the email addresses that are used to send security compliance emails.
- `-SecurityComplianceNotificationPhones` parameter specifies the phone numbers that are used for security compliance.
- `-TechnicalNotificationMails` parameter indicates the email addresses that are used for technical notification emails.

### Example 2: Set MarketingNotificationEmails for a tenant

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
Set-EntraTenantDetail -MarketingNotificationEmails @('amy@contoso.com','henry@contoso.com')
```

This example demonstrates how to set MarketingNotificationEmails detail for a tenant.

- `-MarketingNotificationEmails` parameter indicates the email addresses that are used to send marketing notification emails.

### Example 3: Set SecurityComplianceNotificationMails for a tenant

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
Set-EntraTenantDetail -SecurityComplianceNotificationMails @('john@contoso.com','mary@contoso.com')
```

This example demonstrates how to set SecurityComplianceNotificationMails detail for a tenant.

- `-SecurityComplianceNotificationMails` parameter indicates the email addresses that are used to send security compliance emails.

### Example 4: Set -SecurityComplianceNotificationPhones for a tenant

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
Set-EntraTenantDetail -SecurityComplianceNotificationPhones @('1-555-625-9999', '1-555-233-5544')
```

This example demonstrates how to set MarketingNotificationEmails detail for a tenant.

- `-SecurityComplianceNotificationPhones` parameter specifies the phone numbers that are used for security compliance.

### Example 5: Set TechnicalNotificationMails for a tenant

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
Set-EntraTenantDetail -TechnicalNotificationMails 'peter@contoso.com'
```

This example demonstrates how to set TechnicalNotificationMails detail for a tenant.

- `-TechnicalNotificationMails` parameter indicates the email addresses that are used for technical notification emails.

## Parameters

### -MarketingNotificationEmails

The email addresses that are used to send marketing notification emails.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecurityComplianceNotificationMails

The email addresses that are used to send security compliance emails.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecurityComplianceNotificationPhones

One or more phone numbers that are used for security compliance.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TechnicalNotificationMails

The email addresses that are used for technical notification emails.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrivacyProfile

Represents a company's privacy profile, which includes a privacy statement URL and a contact person for questions regarding the privacy statement.

```yaml
Type: PrivacyProfile
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### None

## Outputs

### System.Object

## Notes

- For more details see [Update organization](https://learn.microsoft.com/graph/api/organization-update).

## Related links

[Get-EntraTenantDetail](Get-EntraTenantDetail.md)
