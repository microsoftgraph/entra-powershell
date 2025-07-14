---
author: msewaweru
description: This article provides details on the New-EntraServicePrincipalPasswordCredential command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/New-EntraServicePrincipalPasswordCredential
schema: 2.0.0
title: New-EntraServicePrincipalPasswordCredential
---

# New-EntraServicePrincipalPasswordCredential

## SYNOPSIS

Creates a password credential for a service principal.

## SYNTAX

```powershell
New-EntraServicePrincipalPasswordCredential
 -ServicePrincipalId <String>
 [-EndDate <DateTime>]
 [-StartDate <DateTime>]
 [-DisplayName <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraServicePrincipalPasswordCredential` cmdlet creates a password credential for a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Create a password credential with StartDate

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
New-EntraServicePrincipalPasswordCredential -ServicePrincipalId $servicePrincipal.Id -DisplayName 'Helpdesk App Credential' -StartDate '2024-11-04T14:14:14Z'
```

```Output
secretText          : A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u
@odata.type         : #microsoft.graph.servicePrincipal
endDateTime         : 08-08-2026 10:30:00
hint                : LY.
customKeyIdentifier :
startDateTime       : 08-08-2024 14:14:14
keyId               : aaaaaaaa-0b0b-1c1c-2d2d-333333333333
@odata.context      : https://graph.microsoft.com/beta/$metadata#servicePrincipals('00001111-aaaa-2222-bbbb-3333cccc4444')/addPassword
displayName         :
StartDate           : 08-08-2024 14:14:14
EndDate             : 08-08-2026 10:30:00
```

This example demonstrates how to create a password credential with StartDate for a service principal in Microsoft Entra ID.  

- `-ServicePrincipalId` parameter specifies the ID of a service principal.
- `-DisplayName` parameter specifies a friendly name for the password.
- `-StarteDate` parameter specifies the date and time at which the password becomes valid.

### Example 2: Create a password credential with EndDate

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
New-EntraServicePrincipalPasswordCredential -ServicePrincipalId $servicePrincipal.Id -DisplayName 'Helpdesk App Credential' -EndDate '2024-11-04T14:14:14Z'
```

```Output
secretText          : A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u
@odata.type         : #microsoft.graph.servicePrincipal
endDateTime         : 08-08-2026 10:30:00
hint                : LY.
customKeyIdentifier :
startDateTime       : 08-08-2024 14:14:14
keyId               : bbbbbbbb-1c1c-2d2d-3e3e-444444444444
@odata.context      : https://graph.microsoft.com/beta/$metadata#servicePrincipals('00001111-aaaa-2222-bbbb-3333cccc4444')/addPassword
displayName         :
StartDate           : 08-08-2024 14:14:14
EndDate             : 08-08-2026 10:30:00
```

This example demonstrates how to create a password credential with EndDate for a service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.
- `-DisplayName` parameter specifies a friendly name for the password.
- `-EndDate` parameter specifies the date and time at which the password expires represented using ISO 8601 format and is always in UTC time.

## PARAMETERS

### -EndDate

The date and time at which the password expires represented using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2024 is 2024-01-01T00:00:00Z.

```yaml
Type: System.DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ServicePrincipalId

Specifies the ID of the service principal.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -StartDate

The date and time at which the password becomes valid. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2024 is 2024-01-01T00:00:00Z.

```yaml
Type: System.DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -DisplayName

The friendly name for the password.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: 
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraServicePrincipalPasswordCredential](Get-EntraServicePrincipalPasswordCredential.md)

[Remove-EntraServicePrincipalPasswordCredential](Remove-EntraServicePrincipalPasswordCredential.md)
