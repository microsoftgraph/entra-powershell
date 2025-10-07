---
author: msewaweru
description: This article provides details on the Remove-EntraBetaApplicationExtensionProperty command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Applications
ms.author: eunicewaweru
ms.date: 08/06/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Remove-EntraBetaApplicationExtensionProperty
schema: 2.0.0
title: Remove-EntraBetaApplicationExtensionProperty
---

# Remove-EntraBetaApplicationExtensionProperty

## SYNOPSIS

Removes an application extension property.

## SYNTAX

```powershell
Remove-EntraBetaApplicationExtensionProperty
 -ApplicationId <String>
 -ExtensionPropertyId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaApplicationExtensionProperty` cmdlet removes an application extension property for an object in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an application extension property

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$extension = Get-EntraApplicationExtensionProperty -ApplicationId $application.Id | Where-Object {$_.Name -eq 'extension_3ed1a24748dd4e4cb91fc0ab09576ff0_NewAttribute'}
Remove-EntraBetaApplicationExtensionProperty -ApplicationId $application.Id -ExtensionPropertyId $extension.Id
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

[Get-EntraBetaApplicationExtensionProperty](Get-EntraBetaApplicationExtensionProperty.md)

[New-EntraBetaApplicationExtensionProperty](New-EntraBetaApplicationExtensionProperty.md)
