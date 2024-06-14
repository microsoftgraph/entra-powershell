---
title: Get-EntraMSApplicationExtensionProperty
description: This article provides details on the Get-EntraMSApplicationExtensionProperty command.

ms.service: entra
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSApplicationExtensionProperty

## SYNOPSIS

Retrieves the list of extension properties on an application object.

## SYNTAX

```powershell
Get-EntraMSApplicationExtensionProperty 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

Retrieves the list of extension properties on an application object.

## EXAMPLES

### Example 1: Get extension properties

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraMSApplicationExtensionProperty -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```output
DeletedDateTime Id                                   AppDisplayName DataType IsSyncedFromOnPremises Name                                                     TargetObjects
--------------- --                                   -------------- -------- ---------------------- ----                                                     -------------
                aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb                String   False                  extension_418f12ad979549bbaebda0102973258b_NewAttribute2 {}
                bbbbbbbb-7777-8888-9999-cccccccccccc                String   False                  extension_418f12ad979549bbaebda0102973258b_NewAttribute1 {}
                cccccccc-8888-9999-0000-dddddddddddd                String   False                  extension_418f12ad979549bbaebda0102973258b_NewAttribute  {}
```

This command gets the extension properties for the specified application in Microsoft Entra ID.

## PARAMETERS

### -ObjectId

The unique identifier of the object specific Microsoft Entra ID object.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Open.MSGraph.Model.GetExtensionPropertiesResponse

## NOTES

## RELATED LINKS

[New-EntraMSApplicationExtensionProperty](New-EntraMSApplicationExtensionProperty.md)

[Remove-EntraMSApplicationExtensionProperty](Remove-EntraMSApplicationExtensionProperty.md)

