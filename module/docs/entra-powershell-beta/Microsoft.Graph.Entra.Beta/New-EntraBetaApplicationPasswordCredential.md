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
online version:
schema: 2.0.0
---

# New-EntraBetaApplicationPasswordCredential

## Synopsis

Creates a password credential for an application.

## Syntax

```powershell
New-EntraBetaApplicationPasswordCredential 
 -ObjectId <String> 
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
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
New-EntraBetaApplicationPasswordCredential -ObjectId 'tttttttt-0000-2222-0000-aaaaaaaaaaaa'
```

```output
CustomKeyIdentifier DisplayName EndDateTime          Hint KeyId                                SecretText                    StartDateTime
------------------- ----------- -----------          ---- -----                                ----------                    -------------
                                3/21/2026 9:48:40 AM n34  tttttttt-0000-2222-0000-aaaaaaaaaaaa wbBNW8kCuiPjNRg9NX98W_aaaaaaa 3/21/2024 9:48:40 AM
```

This command creates new password credential for specified application.

### Example 2: Create a password credential using CustomKeyIdentifier parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
$params = @{
    ObjectId = 'tttttttt-0000-2222-0000-aaaaaaaaaaaa'
    CustomKeyIdentifier = 'demoPassword'
}

New-EntraBetaApplicationPasswordCredential @params
```

```output
CustomKeyIdentifier DisplayName EndDateTime          Hint KeyId                                SecretText                    StartDateTime
------------------- ----------- -----------          ---- -----                                ----------                    -------------
                                3/21/2026 9:48:40 AM n34  tttttttt-0000-2222-0000-aaaaaaaaaaaa wbBNW8kCuiPjNRg9NX98W_aaaaaaa 3/21/2024 9:48:40 AM
```

This command creates new password credential for specified application.

### Example 3: Create a password credential using StartDate parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
$params = @{
    ObjectId = 'tttttttt-0000-2222-0000-aaaaaaaaaaaa'
    StartDate = (Get-Date).AddYears(0)
}

New-EntraBetaApplicationPasswordCredential @params
```

```output
CustomKeyIdentifier DisplayName EndDateTime          Hint KeyId                                SecretText                    StartDateTime
------------------- ----------- -----------          ---- -----                                ----------                    -------------
                                3/21/2026 9:48:40 AM n34  tttttttt-0000-2222-0000-aaaaaaaaaaaa wbBNW8kCuiPjNRg9NX98W_aaaaaaa 3/21/2024 9:48:40 AM
```

This command creates new password credential for specified application.

### Example 4: Create a password credential using EndDate parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
$params = @{
    ObjectId = 'tttttttt-0000-2222-0000-aaaaaaaaaaaa'
    EndDate = (Get-Date).AddYears(2)
}

New-EntraBetaApplicationPasswordCredential @params
```

```output
CustomKeyIdentifier DisplayName EndDateTime          Hint KeyId                                SecretText                    StartDateTime
------------------- ----------- -----------          ---- -----                                ----------                    -------------
                                3/21/2026 9:48:40 AM n34  tttttttt-0000-2222-0000-aaaaaaaaaaaa wbBNW8kCuiPjNRg9NX98W_aaaaaaa 3/21/2024 9:48:40 AM
```

This command creates new password credential for specified application.

## Parameters

### -ObjectId

Specifies the ID of a user in Microsoft Entra ID.

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
