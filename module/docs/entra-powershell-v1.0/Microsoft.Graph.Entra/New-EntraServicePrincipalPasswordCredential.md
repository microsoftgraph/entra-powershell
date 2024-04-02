---
title: New-EntraServicePrincipalPasswordCredential.
description: This article provides details on the New-EntraServicePrincipalPasswordCredential command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/21/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraServicePrincipalPasswordCredential

## SYNOPSIS
Creates a password credential for a service principal.

## SYNTAX

```
New-EntraServicePrincipalPasswordCredential 
 -ObjectId <String>
 [-CustomKeyIdentifier <String>] 
 [-Value <String>] 
 [-EndDate <DateTime>] 
 [-StartDate <DateTime>] 
 [<CommonParameters>]
```

## DESCRIPTION
The New-EntraServicePrincipalPasswordCredential cmdlet creates a password credential for a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Create a password credential with StartDate
```powershell
PS C:\> $StartDate = Get-Date -Year 2024 -Month 3 -Day 25
PS C:\> New-EntraServicePrincipalPasswordCredential -ObjectID "021510b7-e753-40aa-b668-29753295ca34" -StartDate 2024-03-21T14:14:14Z
```
```output
CustomKeyIdentifier DisplayName EndDateTime         Hint KeyId                                SecretText                               StartDateTime
------------------- ----------- -----------         ---- -----                                ----------                               -------------
                                21-03-2026 12:12:13 t9X  6cf8588c-8281-44ba-b448-06ecd8163736 t9X8Q~kSKIXiQwMNU23wxJQ-CP~56AVuf9xqzbOv 21-03-2024 14:14:14
```

This example demonstrates how to create a password credential with StartDate for a service principal in Microsoft Entra ID.  
This command creates a password credential for a service principal.

### Example 2: Create a password credential with EndtDate
```powershell
PS C:\> New-EntraServicePrincipalPasswordCredential -ObjectID "021510b7-e753-40aa-b668-29753295ca34" -EndDate 2030-03-21T14:14:14Z
```
```output
CustomKeyIdentifier DisplayName EndDateTime         Hint KeyId                                SecretText                               StartDateTime
------------------- ----------- -----------         ---- -----                                ----------                               -------------
                                21-03-2030 14:14:14 nDv  7b64a11f-fd72-4338-966e-00dc51a189b6 nDv8Q~B3Mh2w3m7u~NOnvNqiUKUCWYXghaKbKbpt 21-03-2024 12:15:10
```

This example demonstrates how to create a password credential with EndDate for a service principal in Microsoft Entra ID.       
This command creates a password credential for a service principal.

## PARAMETERS

### -CustomKeyIdentifier
Specifies a custom key ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -EndDate
The date and time at which the password expires represented using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2024 is 2024-01-01T00:00:00Z.

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

### -ObjectId
Specifies an object ID.

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
The date and time at which the password becomes valid. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2024 is 2024-01-01T00:00:00Z.

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

### -Value
Specifies the value for the key.

```yaml
Type: String
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

[Get-EntraServicePrincipalPasswordCredential](Get-EntraServicePrincipalPasswordCredential.md)

[Remove-EntraServicePrincipalPasswordCredential](Remove-EntraServicePrincipalPasswordCredential.md)

