---
title: Set-EntraTenantDetail.
description: This article provides details on the Set-EntraTenantDetail command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
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

## Examples

### Example 1: Set contact details for a tenant
```powershell
PS C:\WINDOWS\system32> Set-EntraTenantDetail -MarketingNotificationEmails "amy@contoso.com","henry@contoso.com" -SecurityComplianceNotificationMails "john@contoso.com","mary@contoso.com" -SecurityComplianceNotificationPhones "1-555-625-9999", "1-555-233-5544" -TechnicalNotificationMails "peter@contoso.com"
```

This example demonstrates how to set various contact details for a tenant.

### Example 2: Set MarketingNotificationEmails for a tenant
```powershell
PS C:\WINDOWS\system32> Set-EntraTenantDetail -MarketingNotificationEmails "amy@contoso.com","henry@contoso.com" 
```

This example demonstrates how to set MarketingNotificationEmails detail for a tenant.

### Example 3: Set SecurityComplianceNotificationMails for a tenant
```powershell
PS C:\WINDOWS\system32> Set-EntraTenantDetail -SecurityComplianceNotificationMails "john@contoso.com","mary@contoso.com" 
```

This example demonstrates how to set SecurityComplianceNotificationMails detail for a tenant.

### Example 4: Set -SecurityComplianceNotificationPhones for a tenant
```powershell
PS C:\WINDOWS\system32> Set-EntraTenantDetail -SecurityComplianceNotificationPhones "1-555-625-9999", "1-555-233-5544" 
```

This example demonstrates how to set MarketingNotificationEmails detail for a tenant.

### Example 5: Set TechnicalNotificationMails for a tenant
```powershell
PS C:\WINDOWS\system32> Set-EntraTenantDetail -TechnicalNotificationMails "peter@contoso.com"
```

This example demonstrates how to set TechnicalNotificationMails detail for a tenant.


## Parameters

### -MarketingNotificationEmails
The email address that is used to send marketing notification emails.

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
The email address that is used to send security compliance emails.

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
The phone number(s) that are used for security compliance.

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
The email addres(es) that are used for technical notification emails.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### None
## Outputs

### System.Object
## Notes

## Related Links

[Get-EntraTenantDetail](Get-EntraTenantDetail.md)
