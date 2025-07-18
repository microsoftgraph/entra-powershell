---
author: msewaweru
description: This article provides details on the New-EntraBetaApplicationPasswordCredential command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaApplicationPasswordCredential
schema: 2.0.0
title: New-EntraBetaApplicationPasswordCredential
---

# New-EntraBetaApplicationPasswordCredential

## SYNOPSIS

Creates a password credential for an application.

## SYNTAX

```powershell
New-EntraBetaApplicationPasswordCredential
 -ApplicationId <String>
 [-CustomKeyIdentifier <String>]
 [-StartDate <DateTime>]
 [-EndDate <DateTime>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaApplicationPasswordCredential` cmdlet creates a password credential for an application in Microsoft Entra ID.

## EXAMPLES

### Example 1: Create a password credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "displayName eq '<displayName>'"
$secret = New-EntraBetaApplicationPasswordCredential -ApplicationId $application.Id
$secret | Format-List
```

```Output
CustomKeyIdentifier  : 77 97 114 97 32 76 117 120 117 114 121...
Value                : wbBNW8kCuiPjNRg9NX98W_aaaaaaa
DisplayName          : Contoso Automation account
EndDateTime          : 5/9/2027 11:53:40 AM
Hint                 : WBB
KeyId                : tttttttt-0000-2222-0000-aaaaaaaaaaaa
SecretText           : wbBNW8kCuiPjNRg9NX98W_aaaaaaa
StartDateTime        : 5/9/2025 11:53:39 AM
```

This command creates new password credential for specified application.

- `-ApplicationId` Specifies the ID of an application.

### Example 2: Create a password credential using CustomKeyIdentifier parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "displayName eq '<displayName>'"
$secret = New-EntraBetaApplicationPasswordCredential -ApplicationId $application.Id -CustomKeyIdentifier '<userfriendlyDisplayName>'
$secret | Format-List
```

```Output
CustomKeyIdentifier  : 77 97 114 97 32 76 117 120 117 114 121...
Value                : wbBNW8kCuiPjNRg9NX98W_aaaaaaa
DisplayName          : Contoso Automation account
EndDateTime          : 5/9/2027 11:53:40 AM
Hint                 : WBB
KeyId                : tttttttt-0000-2222-0000-aaaaaaaaaaaa
SecretText           : wbBNW8kCuiPjNRg9NX98W_aaaaaaa
StartDateTime        : 5/9/2025 11:53:39 AM
```

This command creates new password credential for specified application.

- `-ApplicationId` Specifies the ID of an application.
- `-CustomKeyIdentifier` Speicifies unique binary identifier.

### Example 3: Create a password credential using StartDate parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "displayName eq '<displayName>'"
$startDate = (Get-Date).AddYears(0)
$secret = New-EntraBetaApplicationPasswordCredential -ApplicationId $application.Id -CustomKeyIdentifier '<userfriendlyDisplayName>' -StartDate $startDate
$secret | Format-List
```

```Output
CustomKeyIdentifier  : 77 97 114 97 32 76 117 120 117 114 121...
Value                : wbBNW8kCuiPjNRg9NX98W_aaaaaaa
DisplayName          : Contoso Automation account
EndDateTime          : 5/9/2027 11:53:40 AM
Hint                 : WBB
KeyId                : tttttttt-0000-2222-0000-aaaaaaaaaaaa
SecretText           : wbBNW8kCuiPjNRg9NX98W_aaaaaaa
StartDateTime        : 5/9/2025 11:53:39 AM
```

This command creates new password credential for specified application.

- `-ApplicationId` Specifies the ID of an application.
- `-StartDate` Speicifies the date and time at which the password becomes valid.

### Example 4: Create a password credential using EndDate parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "displayName eq '<displayName>'"
$endDate = (Get-Date).AddYears(2)
$secret = New-EntraBetaApplicationPasswordCredential -ApplicationId $application.Id -CustomKeyIdentifier '<userfriendlyDisplayName>' -EndDate $endDate
$secret | Format-List
```

```Output
CustomKeyIdentifier  : 77 97 114 97 32 76 117 120 117 114 121...
Value                : wbBNW8kCuiPjNRg9NX98W_aaaaaaa
DisplayName          : Contoso Automation account
EndDateTime          : 5/9/2027 11:53:40 AM
Hint                 : WBB
KeyId                : tttttttt-0000-2222-0000-aaaaaaaaaaaa
SecretText           : wbBNW8kCuiPjNRg9NX98W_aaaaaaa
StartDateTime        : 5/9/2025 11:53:39 AM
```

This command creates new password credential for specified application.

- `-ApplicationId` Specifies the ID of an application.
- `-EndDate` Speicifies The date and time at which the password expires.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Remove-EntraBetaApplicationPasswordCredential](Remove-EntraBetaApplicationPasswordCredential.md)
