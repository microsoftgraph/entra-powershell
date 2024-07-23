---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaApplicationExtensionProperty

schema: 2.0.0
---

# New-EntraBetaApplicationExtensionProperty

## Synopsis
Creates an application extension property.

## Syntax

```
New-EntraBetaApplicationExtensionProperty -ObjectId <String> [-DataType <String>] [-Name <String>]
 [-TargetObjects <System.Collections.Generic.List`1[System.String]>] [<CommonParameters>]
```

## Description
The New-EntraBetaApplicationExtensionProperty cmdlet creates an application extension property for an object in Azure Active Directory.

## Examples

### Example 1: Create an extension property
```
PS C:\>New-EntraBetaApplicationExtensionProperty -ObjectID "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -DataType "string" -Name "NewAttribute"


ObjectId                             Name                                                    TargetObjects
--------                             ----                                                    -------------
3ddd22e7-a150-4bb3-b100-e410dea1cb84 extension_36ee4c6c081240a2b820b22ebd02bce3_NewAttribute {}
```

This command creates an application extension property of the string type for the specified object.

## Parameters

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
Specifies a unique ID of an application in Azure Active Directory.

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

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaApplicationExtensionProperty]()

[Remove-EntraBetaApplicationExtensionProperty]()

