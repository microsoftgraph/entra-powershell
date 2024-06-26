---
Title: Remove-EntraApplicationKeyCredential.
Description: This article provides details on the Remove-EntraApplicationKeyCredential command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG
Author: msewaweru
External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Remove-EntraApplicationKeyCredential

## Synopsis
Removes a key credential from an application.

## Syntax

```powershell
Remove-EntraApplicationKeyCredential
 -ObjectId <String> 
 -KeyId <String> 
 [<CommonParameters>]
```

## Description
The Remove-EntraApplicationKeyCredential cmdlet removes a key credential from an application.

## Examples

### Example 1: Remove a key credential
```
PS C:\> Remove-EntraApplicationKeyCredential -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -KeyId "6aa971c6-3040-45df-87ed-581c8c09ff2b"
```

This command removes the specified key credential from the specified application.

## Parameters


### -KeyId
Specifies a custom key ID.

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

### -ObjectId
Specifies a unique ID of an application in Microsoft Entra ID.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraApplicationKeyCredential](Get-EntraApplicationKeyCredential.md)

[New-EntraApplicationKeyCredential](New-EntraApplicationKeyCredential.md)