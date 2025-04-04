---
title: New-EntraBetaApplicationPasswordCredential
description: This article provides details on the New-EntraBetaApplicationPasswordCredential command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaApplicationPasswordCredential

schema: 2.0.0
---

# New-EntraBetaApplicationPasswordCredential

## Synopsis

Creates a password credential for an application.

## Syntax

```powershell
New-EntraBetaApplicationPasswordCredential
 -ApplicationId <String>
 [-CustomKeyIdentifier <String>]
 [-StartDate <DateTime>]
 [-EndDate <DateTime>]
 [<CommonParameters>]
```

## Description

The `New-EntraBetaApplicationPasswordCredential` cmdlet creates a password credential for an application in Microsoft Entra ID.

## Examples

### Example 1: Create a password credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "displayName eq '<displayName>'"
New-EntraBetaApplicationPasswordCredential -ApplicationId $application.Id
```

```Output
CustomKeyIdentifier DisplayName EndDateTime          Hint KeyId                                SecretText                    StartDateTime
------------------- ----------- -----------          ---- -----                                ----------                    -------------
                                3/21/2026 9:48:40 AM n34  tttttttt-0000-2222-0000-aaaaaaaaaaaa wbBNW8kCuiPjNRg9NX98W_aaaaaaa 3/21/2024 9:48:40 AM
```

This command creates new password credential for specified application.

- `-ApplicationId` Specifies the ID of an application.

### Example 2: Create a password credential using CustomKeyIdentifier parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "displayName eq '<displayName>'"
$parameters = @{
    ApplicationId = $application.Id
    CustomKeyIdentifier = '<userfriendlyDisplayName>'
}
New-EntraBetaApplicationPasswordCredential @parameters
```

```Output
CustomKeyIdentifier                           DisplayName  EndDateTime          Hint KeyId                                SecretText                               StartDat
                                                                                                                                                                   eTime
-------------------                           -----------  -----------          ---- -----                                ----------                               --------
100 101 109 111 80 97 115 115 119 111 114 100 demoPassword 6/10/2026 7:43:45 AM 9tb  tttttttt-0000-2222-0000-aaaaaaaaaaaa wbBNW8kCuiPjNRg9NX98W_EaU6cqG 6/10/...
```

This command creates new password credential for specified application.

- `-ApplicationId` Specifies the ID of an application.
- `-CustomKeyIdentifier` Speicifies unique binary identifier.

### Example 3: Create a password credential using StartDate parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "displayName eq '<displayName>'"
$parameters = @{
    ApplicationId = $application.Id
    StartDate = (Get-Date).AddYears(0)
    CustomKeyIdentifier = '<userfriendlyDisplayName>'
}

New-EntraBetaApplicationPasswordCredential @parameters
```

```Output
CustomKeyIdentifier DisplayName EndDateTime          Hint KeyId                                SecretText                    StartDateTime
------------------- ----------- -----------          ---- -----                                ----------                    -------------
                                3/21/2026 9:48:40 AM n34  tttttttt-0000-2222-0000-aaaaaaaaaaaa wbBNW8kCuiPjNRg9NX98W_aaaaaaa 3/21/2024 9:48:40 AM
```

This command creates new password credential for specified application.

- `-ApplicationId` Specifies the ID of an application.
- `-StartDate` Speicifies the date and time at which the password becomes valid.

### Example 4: Create a password credential using EndDate parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "displayName eq '<displayName>'"
$parameters = @{
    ApplicationId = $application.Id
    EndDate = (Get-Date).AddYears(2)
    CustomKeyIdentifier = '<userfriendlyDisplayName>'
}

New-EntraBetaApplicationPasswordCredential @parameters
```

```Output
CustomKeyIdentifier DisplayName EndDateTime          Hint KeyId                                SecretText                    StartDateTime
------------------- ----------- -----------          ---- -----                                ----------                    -------------
                                3/21/2026 9:48:40 AM n34  tttttttt-0000-2222-0000-aaaaaaaaaaaa wbBNW8kCuiPjNRg9NX98W_aaaaaaa 3/21/2024 9:48:40 AM
```

This command creates new password credential for specified application.

- `-ApplicationId` Specifies the ID of an application.
- `-EndDate` Speicifies The date and time at which the password expires.

## Parameters

### -ApplicationId

Specifies the ID of an application in Microsoft Entra ID.

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

### -CustomKeyIdentifier

A unique binary identifier.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -StartDate

The date and time at which the password becomes valid.

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

### -EndDate

The date and time at which the password expires.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Remove-EntraBetaApplicationPasswordCredential](Remove-EntraBetaApplicationPasswordCredential.md)
