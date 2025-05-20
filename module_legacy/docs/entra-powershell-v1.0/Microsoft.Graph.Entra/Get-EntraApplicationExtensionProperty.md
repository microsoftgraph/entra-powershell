---
title: Get-EntraApplicationExtensionProperty
description: This article provides details on the Get-EntraApplicationExtensionProperty command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraApplicationExtensionProperty

schema: 2.0.0
---

# Get-EntraApplicationExtensionProperty

## Synopsis

Gets application extension properties.

## Syntax

```powershell
Get-EntraApplicationExtensionProperty
 -ApplicationId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraApplicationExtensionProperty` cmdlet gets application extension properties in Microsoft Entra ID.

## Examples

### Example 1: Get extension properties

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$Application = Get-EntraApplication -SearchString '<application-name>'
Get-EntraApplicationExtensionProperty -ApplicationId $Application.Id
```

```Output
DeletedDateTime Id                                   AppDisplayName DataType IsMultiValued IsSyncedFromOnPremises Name                                                    TargetObjects
--------------- --                                   -------------- -------- ------------- ---------------------- ----                                                    -------------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb                Boolean  False         False                  extension_c371a443f6734a3e8982a26357fb7d59_NewAttribute {User}
```

This command gets the extension properties for the specified application in Microsoft Entra ID. You cane use the command `Get-EntraApplication` to get application ID.

- `-ApplicationId` parameter specifies the unique identifier of an application.

## Parameters

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

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[New-EntraApplicationExtensionProperty](New-EntraApplicationExtensionProperty.md)

[Remove-EntraApplicationExtensionProperty](Remove-EntraApplicationExtensionProperty.md)
