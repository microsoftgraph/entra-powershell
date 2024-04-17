---
title: New-EntraApplicationExtensionProperty
description: This article provides details on the New-EntraApplicationExtensionProperty command.

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

# New-EntraApplicationExtensionProperty

## SYNOPSIS
Creates an application extension property.

## SYNTAX

```powershell
New-EntraApplicationExtensionProperty 
 -ObjectId <String> 
 -Name <String>
 [-DataType <String>]     
 [-TargetObjects <System.Collections.Generic.List`1[System.String]>] 
 [<CommonParameters>]
```

## DESCRIPTION
The New-EntraApplicationExtensionProperty cmdlet creates an application extension property for an object in Microsoft Entra ID.

## EXAMPLES

### Example 1: Create an extension property
```powershell
PS C:\>New-EntraApplicationExtensionProperty -ObjectID "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Name "NewAttribute"
```

```output
DeletedDateTime Id                                   AppDisplayName  DataType IsSyncedFromOnPremises Name                                                    TargetObjects
--------------- --                                   --------------  -------- ---------------------- ----                                                    -------------
                d083d12d-c280-4a23-a644-b4e71a09a4cb my new test app String   False                  extension_ec5edf3fe79749dd8d1e7760a1c1c943_NewAttribute {}
```

This command creates an application extension property of the string type for the specified object.

### Example 2: Create an extension property with data type parameter
```powershell
PS C:\>New-EntraApplicationExtensionProperty -ObjectID "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Name "NewAttribute" -DataType "boolean"
```

```output
DeletedDateTime Id                                   AppDisplayName  DataType IsSyncedFromOnPremises Name                                                    TargetObjects
--------------- --                                   --------------  -------- ---------------------- ----                                                    -------------
                d083d12d-c280-4a23-a644-b4e71a09a4cb my new test app Boolean  False                  extension_ec5edf3fe79749dd8d1e7760a1c1c943_NewAttribute {}
```

This command creates an application extension property of the specified data type for the specified object.

### Example 3: Create an extension property with targets parameter
```powershell
PS C:\>$targets = New-Object System.Collections.Generic.List[System.String]
PS C:\>$targets.Add('User')
PS C:\>New-EntraApplicationExtensionProperty -ObjectID "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -Name "NewAttribute" -TargetObjects $targets
```

```output
DeletedDateTime Id                                   AppDisplayName  DataType IsSyncedFromOnPremises Name                                                    TargetObjects
--------------- --                                   --------------  -------- ---------------------- ----                                                    -------------
                d083d12d-c280-4a23-a644-b4e71a09a4cb my new test app String   False                  extension_ec5edf3fe79749dd8d1e7760a1c1c943_NewAttribute {User}
```

The first command initializes new generic string list collection.  

The second command adds an item to the list.  

The final command creates an application extension property with the specified target objects for the specified object.

## PARAMETERS

### -DataType
Specifies the data type of the extension property.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies the data type of the extension property.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

### -TargetObjects
Specifies target objects.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraApplicationExtensionProperty](Get-EntraApplicationExtensionProperty.md)

[Remove-EntraApplicationExtensionProperty](Remove-EntraApplicationExtensionProperty.md)

