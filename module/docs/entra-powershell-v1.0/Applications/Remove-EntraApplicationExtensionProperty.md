---
author: msewaweru
description: This article provides details on the Remove-EntraApplicationExtensionProperty command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraApplicationExtensionProperty
schema: 2.0.0
title: Remove-EntraApplicationExtensionProperty
---

# Remove-EntraApplicationExtensionProperty

## SYNOPSIS

Removes an application extension property.

## SYNTAX

```powershell
Remove-EntraApplicationExtensionProperty
 -ExtensionPropertyId <String>
 -ApplicationId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraApplicationExtensionProperty` cmdlet removes an application extension property for an object in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an application extension property

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$extension = Get-EntraApplicationExtensionProperty -ApplicationId $application.Id | Where-Object {$_.Name -eq 'extension_3ed1a24748dd4e4cb91fc0ab09576ff0_NewAttribute'}
Remove-EntraApplicationExtensionProperty -ApplicationId $application.Id -ExtensionPropertyId $extension.Id
```

This example removes the extension property that has the specified ID from an application in Microsoft Entra ID.

- `-ApplicationId` parameter specifies the unique identifier of an application.
- `-ExtensionPropertyId` parameter specifies the  unique identifier of the extension property to remove.

## PARAMETERS

### -ExtensionPropertyId

Specifies the unique ID of the extension property to remove.

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

### -ApplicationId

Specifies the unique ID of an application in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraApplicationExtensionProperty](Get-EntraApplicationExtensionProperty.md)

[New-EntraApplicationExtensionProperty](New-EntraApplicationExtensionProperty.md)
