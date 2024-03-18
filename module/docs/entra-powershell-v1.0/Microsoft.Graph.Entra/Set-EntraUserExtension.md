---
title: Set-EntraUserExtension.
description: This article provides details on the Set-EntraUserExtension command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraUserExtension

## SYNOPSIS
Sets a user extension.

## SYNTAX

### SetMultiple
```
Set-EntraUserExtension
-ExtensionNameValues <System.Collections.Generic.Dictionary`2[System.String,System.String]> -ObjectId <String>
[<CommonParameters>]
```

### SetSingle
```
Set-EntraUserExtension 
-ObjectId <String> 
-ExtensionName <String> 
-ExtensionValue <String> 
[<CommonParameters>]
```

## DESCRIPTION
The Set-EntraUserExtension cmdlet sets a user extension in Microsoft Entra ID.

## EXAMPLES

### Example 1: Set the value of an extension attribute for a user
```powershell
PS C:\> $User = Get-EntraUser -Top 1
PS C:\> Set-EntraUserExtension -ObjectId $User.ObjectId -ExtensionName extension_e5e29b8a85d941eab8d12162bd004528_extensionAttribute8 -ExtensionValue "New Value"
```

The first command gets a user by using the Get-EntraUser (./Get-EntraUser.md) cmdlet, and then stores it in the $User variable.

The second command  sets the value of the extension attribute that has specific name to the value New Value.
You can get extension attribute names by using the Get-EntraExtensionProperty (./Get-EntraExtensionProperty.md) cmdlet.

## PARAMETERS

### -ExtensionName
Specifies the name of an extension.

```yaml
Type: String
Parameter Sets: SetSingle
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExtensionNameValues
Specifies extension name values.

```yaml
Type: System.Collections.Generic.Dictionary`2[System.String,System.String]
Parameter Sets: SetMultiple
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExtensionValue
Specifies an extension value.

```yaml
Type: String
Parameter Sets: SetSingle
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of an object.

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

[Get-EntraUser](Get-EntraUser.md)

[Get-EntraUserExtension](Get-EntraUserExtension.md)

[Get-AzureAdExtensionProperty](Get-AzureAdExtensionProperty.md)

[Remove-EntraUserExtension](Remove-EntraUserExtension.md)

