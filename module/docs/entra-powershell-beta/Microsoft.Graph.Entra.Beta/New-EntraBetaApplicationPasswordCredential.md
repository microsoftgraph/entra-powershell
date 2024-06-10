---
title: New-EntraBetaApplicationPasswordCredential
description: This article provides details on the Set-EntraBetaApplicationProxyConnector command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/21/2024
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

## SYNOPSIS

Creates a password credential for an application.

## SYNTAX

```powershell
New-EntraBetaApplicationPasswordCredential 
 -ObjectId <String> 
 [-CustomKeyIdentifier <String>]
 [-StartDate <DateTime>] 
 [-EndDate <DateTime>] 
 [<CommonParameters>]
```

## DESCRIPTION

The New-EntraBetaApplicationPasswordCredential cmdlet creates a password credential for an application in Microsoft Entra ID.

## EXAMPLES

### Example 1: Create a password credential

```powershell
PS C:\>New-EntraBetaApplicationPasswordCredential -ObjectId 'tttttttt-0000-2222-0000-aaaaaaaaaaaa'
```

```output
CustomKeyIdentifier DisplayName EndDateTime          Hint KeyId                                SecretText                    StartDateTime
------------------- ----------- -----------          ---- -----                                ----------                    -------------
                                3/21/2026 9:48:40 AM n34  b30c6289-7903-4a61-97e6-2ada9742fd3b wbBNW8kCuiPjNRg9NX98W_EaU6cqG 3/21/2024 9:48:40 AM
```

This command creates new password credential for specified application.

### Example 2: Create a password credential using CustomKeyIdentifier parameter

```powershell
PS C:\>New-EntraBetaApplicationPasswordCredential -ObjectId 'tttttttt-0000-2222-0000-aaaaaaaaaaaa' -CustomKeyIdentifier 'demoPassword'
```

```output
CustomKeyIdentifier                           DisplayName  EndDateTime          Hint KeyId                                SecretText                               StartDat
                                                                                                                                                                   eTime
-------------------                           -----------  -----------          ---- -----                                ----------                               --------
100 101 109 111 80 97 115 115 119 111 114 100 demoPassword 6/10/2026 7:43:45 AM 9tb  064b5d60-0ee6-462d-9134-b67ea4abe4b6 wbBNW8kCuiPjNRg9NX98W_EaU6cqG 6/10/...

```

This command creates new password credential for specified application.

### Example 3: Create a password credential using StartDate parameter

```powershell
PS C:\>New-EntraBetaApplicationPasswordCredential -ObjectId '3ddd22e7-a150-4bb3-b100-e410dea1cb84' -StartDate (get-date).AddYears(0)
```

```output
CustomKeyIdentifier DisplayName EndDateTime          Hint KeyId                                SecretText                    StartDateTime
------------------- ----------- -----------          ---- -----                                ----------                    -------------
                                3/21/2026 9:48:40 AM n34  b30c6289-7903-4a61-97e6-2ada9742fd3b wbBNW8kCuiPjNRg9NX98W_EaU6cqG 3/21/2024 9:48:40 AM
```

This command creates new password credential for specified application.

### Example 4: Create a password credential using EndDate parameter

```powershell
PS C:\>New-EntraBetaApplicationPasswordCredential -ObjectId '3ddd22e7-a150-4bb3-b100-e410dea1cb84' -EndDate (get-date).AddYears(2)
```

```output
CustomKeyIdentifier DisplayName EndDateTime          Hint KeyId                                SecretText                    StartDateTime
------------------- ----------- -----------          ---- -----                                ----------                    -------------
                                3/21/2026 9:48:40 AM n34  b30c6289-7903-4a61-97e6-2ada9742fd3b wbBNW8kCuiPjNRg9NX98W_EaU6cqG 3/21/2024 9:48:40 AM
```

This command creates new password credential for specified application.

## PARAMETERS

### -ObjectId

Specifies the ID of a user in Microsoft Entra ID.

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

### -CustomKeyIdentifier

A unique binary identifier.

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

### -StartDate

The date and time at which the password becomes valid.

```yaml
Type: DateTime
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
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaApplicationPasswordCredential](Get-EntraBetaApplicationPasswordCredential.md)

[Remove-EntraBetaApplicationPasswordCredential](Remove-EntraBetaApplicationPasswordCredential.md)
