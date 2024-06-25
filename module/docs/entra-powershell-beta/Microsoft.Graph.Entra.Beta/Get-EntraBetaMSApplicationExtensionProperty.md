---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSApplicationExtensionProperty

## Synopsis
Retrieves the list of extension properties on an application object.

## Syntax

```
Get-EntraBetaMSApplicationExtensionProperty -ObjectId <String> [<CommonParameters>]
```

## Description
Retrieves the list of extension properties on an application object.

## Examples

### Example 1: Get extension properties
```
PS C:\>Get-EntraBetaMSApplicationExtensionProperty -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84"

          ObjectId                             Name                                                    TargetObjects
          --------                             ----                                                    -------------
          344ed560-f8e7-410e-ab9f-c795a7df5c36 extension_36ee4c6c081240a2b820b22ebd02bce3_NewAttribute {}
```

This command gets the extension properties for the specified application in Azure Active Directory.

## Parameters

### -ObjectId
The unique identifier of the object specific Azure Active Directory object

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### string
## Outputs

### Microsoft.Open.MSGraph.Model.GetExtensionPropertiesResponse
## Notes

## Related LINKS

[New-EntraBetaMSApplicationExtensionProperty]()

[Remove-EntraBetaMSApplicationExtensionProperty]()

