---
author: msewaweru
description: This article provides details on the New-EntraBetaApplicationExtensionProperty command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/06/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/New-EntraBetaApplicationExtensionProperty
schema: 2.0.0
title: New-EntraBetaApplicationExtensionProperty
---

# New-EntraBetaApplicationExtensionProperty

## SYNOPSIS

Creates an application extension property.

## SYNTAX

```powershell
New-EntraBetaApplicationExtensionProperty
 -ApplicationId <String>
 [-DataType <String>]
 [-Name <String>]
 [-TargetObjects <System.Collections.Generic.List`1[System.String]>]
 [-IsMultiValued <Boolean>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaApplicationExtensionProperty` cmdlet creates an application extension property for an object in Microsoft Entra ID.

## EXAMPLES

### Example 1: Create an extension property

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
New-EntraBetaApplicationExtensionProperty -ApplicationId $application.Id -Name 'NewAttribute'
```

```Output
DeletedDateTime Id                                   AppDisplayName  DataType IsSyncedFromOnPremises Name                                                    TargetObjects
--------------- --                                   --------------  -------- ---------------------- ----                                                    -------------
                11112222-bbbb-3333-cccc-4444dddd5555 My new test app String   False                  extension_11112222-bbbb-3333-cccc-4444dddd5555_NewAttribute {}
```

This command creates an application extension property of the string type for the specified object.

- `-ApplicationId` parameter specifies the unique identifier of an application.
- `-Name` parameter specifies the name of the extension property.

### Example 2: Create an extension property with data type parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
New-EntraBetaApplicationExtensionProperty -ApplicationId $application.Id -Name 'NewAttribute1' -DataType 'Boolean'
```

```Output
DeletedDateTime Id                                   AppDisplayName  DataType IsSyncedFromOnPremises Name                                                    TargetObjects
--------------- --                                   --------------  -------- ---------------------- ----                                                    -------------
                11112222-bbbb-3333-cccc-4444dddd5555 My new test app Boolean  False                  extension_11112222-bbbb-3333-cccc-4444dddd5555_NewAttribute {}
```

This command creates an application extension property of the specified data type for the specified object.

- `-ApplicationId` parameter specifies the unique identifier of an application.
- `-Name` parameter specifies the name of the extension property.
- `-DataType` parameter specifies the data type of the value the extension property can hold.

### Example 3: Create an extension property with targets parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
$targets = New-Object System.Collections.Generic.List[System.String]
$targets.Add('User')
New-EntraBetaApplicationExtensionProperty -ApplicationId $application.Id -Name 'NewAttribute2' -TargetObjects $targets
```

```Output
DeletedDateTime Id                                   AppDisplayName  DataType IsSyncedFromOnPremises Name                                                    TargetObjects
--------------- --                                   --------------  -------- ---------------------- ----                                                    -------------
                11112222-bbbb-3333-cccc-4444dddd5555 My new test app String   False                  extension_11112222-bbbb-3333-cccc-4444dddd5555_NewAttribute {User}
```

The example shows how to create an application extension property with the specified target objects for the specified object.

- `-ApplicationId` parameter specifies the unique identifier of an application.
- `-Name` parameter specifies the name of the extension property.
- `-TargetObjects` parameter specifies the Microsoft Graph resources that use the extension property. All values must be in PascalCase.

## PARAMETERS

### -DataType

Specifies the data type of the value the extension property can hold. Following values are supported.

- Binary - 256 bytes maximum
- Boolean
- DateTime - Must be specified in ISO 8601 format. Will be stored in UTC.
- Integer - 32-bit value.
- LargeInteger - 64-bit value.
- String - 256 characters maximum

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies the name of the extension property.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationId

Specifies a unique ID of an application in Microsoft Entra ID.

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

### -TargetObjects

Specifies the Microsoft Graph resources that can use the extension property. All values must be in PascalCase. The following values are supported.

- User
- Group
- AdministrativeUnit
- Application
- Device
- Organization

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsMultiValued

Specifies whether the extension property supports multiple values. Set this parameter to $true if the extension property can hold multiple values; otherwise, set it to $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaApplicationExtensionProperty](Get-EntraBetaApplicationExtensionProperty.md)

[Remove-EntraBetaApplicationExtensionProperty](Remove-EntraBetaApplicationExtensionProperty.md)
