---
title: Set-EntraBetaPartnerInformation
description: This article provides details on the Set-EntraBetaPartnerInformation command.

ms.service: active-directory
ms.topic: reference
ms.date: 05/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Set-EntraBetaPartnerInformation

## Synopsis
Sets company information for partners.

## Syntax

```powershell
Set-EntraBetaPartnerInformation 
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
The Set-EntraBetaPartnerInformation cmdlet is used by partners to set partner-specific properties.
These properties can view by all tenants that the partner has access to.

## Examples

### Example 1: Update the help URL
```powershell
PS C:\> Set-EntraBetaPartnerInformation -PartnerHelpUrl "http://www.help.contoso.com"
```
This command updates the help URL for this partner.

### Example 2: Update the Support URL
```powershell
PS C:\> Set-EntraBetaPartnerInformation -PartnerSupportUrl "http://www.test1.com"
```
This command updates the Support URL for this partner.

### Example 3: Update the Commerce URL
```powershell
PS C:\> Set-EntraBetaPartnerInformation -PartnerCommerceUrl "http://www.test1.com" 
```
This command updates the Commerce URL for this partner.

### Example 4: Update the SupportEmails
```powershell
PS C:\> Set-EntraBetaPartnerInformation -PartnerSupportEmails "contoso@example.com" 
```
This command updates the SupportEmails for this partner.

### Example 5: Update the SupportTelephones
```powershell
PS C:\> Set-EntraBetaPartnerInformation -PartnerSupportTelephones "2342" -TenantId "b73cc049-a025-4441-ba3a-8826d9a68ecc"
```
This command updates the SupportTelephones for this partner.

## Parameters

### -PartnerCommerceUrl
Specifies the URL for the partner's commerce website.

```yaml
Type: String
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
Type: String
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TenantId
Specifies the unique ID of the tenant on which to perform the operation.
The default value is the tenant of the current user.
This parameter applies only to partner users.

```yaml
Type: Guid
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS
[Get-EntraBetaPartnerInformation](Get-EntraBetaPartnerInformation.md)