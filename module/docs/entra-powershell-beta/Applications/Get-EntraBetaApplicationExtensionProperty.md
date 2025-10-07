---
description: This article provides details on the Get-EntraBetaApplicationExtensionProperty command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Applications
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Get-EntraBetaApplicationExtensionProperty
schema: 2.0.0
title: Get-EntraBetaApplicationExtensionProperty
---

# Get-EntraBetaApplicationExtensionProperty

## SYNOPSIS

Gets application extension properties.

## SYNTAX

### ByApplicationId

```powershell
Get-EntraBetaApplicationExtensionProperty
 -ApplicationId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaApplicationExtensionProperty` cmdlet gets application extension properties in Microsoft Entra ID.

## EXAMPLES

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

## PARAMETERS

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
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaApplicationExtensionProperty](New-EntraBetaApplicationExtensionProperty.md)

[Remove-EntraBetaApplicationExtensionProperty](Remove-EntraBetaApplicationExtensionProperty.md)
