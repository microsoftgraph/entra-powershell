---
title: Get-EntraBetaApplicationExtensionProperty
description: This article provides details on the Get-EntraBetaApplicationExtensionProperty command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaApplicationExtensionProperty

schema: 2.0.0
---

# Get-EntraBetaApplicationExtensionProperty

## Synopsis

Gets application extension properties.

## Syntax

```powershell
Get-EntraBetaApplicationExtensionProperty
 -ApplicationId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaApplicationExtensionProperty` cmdlet gets application extension properties in Microsoft Entra ID.

## Examples

### Example 1: Get extension properties

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Helpdesk Application'"
Get-EntraBetaApplicationExtensionProperty -ApplicationId $application.Id
```

```Output
DeletedDateTime Id                                   AppDisplayName DataType IsMultiValued IsSyncedFromOnPremises Name                                                    TargetObjects
--------------- --                                   -------------- -------- ------------- ---------------------- ----                                                    -------------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb                Boolean  False         False                  extension_c371a443f6734a3e8982a26357fb7d59_NewAttribute {User}
```

This command gets the extension properties for the specified application in Microsoft Entra ID. You cane use the command `Get-EntraBetaApplication` to get application ID.

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

[New-EntraBetaApplicationExtensionProperty](New-EntraBetaApplicationExtensionProperty.md)

[Remove-EntraBetaApplicationExtensionProperty](Remove-EntraBetaApplicationExtensionProperty.md)
