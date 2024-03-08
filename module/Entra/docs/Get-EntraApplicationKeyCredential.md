---
title: Get-EntraApplicationKeyCredential
description: This article provides details on the Get-EntraApplicationKeyCredential command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraApplicationKeyCredential

## SYNOPSIS
Gets the key credentials for an application.

## SYNTAX

```powershell
Get-EntraApplicationKeyCredential 
    -ObjectId <String> 
    [-InformationAction <ActionPreference>] 
    [-InformationVariable <String>] 
    [<CommonParameters>]
```

## DESCRIPTION
The **Get-EntraApplicationKeyCredential** cmdlet gets the key credentials for an application.

## EXAMPLES

### Example 1: Get key credentials
```powershell
PS C:\> Get-EntraApplicationKeyCredential -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84"
```

```output
CustomKeyIdentifier : {116, 101, 115, 116}
EndDate             : 10/23/2024 11:36:56 AM
KeyId               : 52ab6cca-bc59-4f06-8450-75a3d2b8e53b
StartDate           : 11/22/2023 11:35:16 AM
Type                : Symmetric
Usage               : Sign
Value               :

CustomKeyIdentifier : {84, 101, 115, 116}
EndDate             : 10/23/2024 9:46:49 AM
KeyId               : 2e5143ee-9912-40c1-8c6a-a84f8124a6af
StartDate           : 10/23/2023 9:46:48 AM
Type                : Symmetric
Usage               : Sign
Value               :
```

This command gets the key credentials for the specified application.

## PARAMETERS

### -InformationAction
Specifies how this cmdlet responds to an information event.

The acceptable values for this parameter are:

- Continue
- Ignore
- Inquire
- SilentlyContinue
- Stop
- Suspend

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
Specifies an information variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
Specifies a unique ID of an application in Microsoft Entra ID for which to get key credentials

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraApplicationKeyCredential](New-EntraApplicationKeyCredential.md)

[Remove-EntraApplicationKeyCredential](Remove-EntraApplicationKeyCredential.md)

