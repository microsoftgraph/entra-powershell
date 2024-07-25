---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaUserThumbnailPhoto

schema: 2.0.0
---

# Get-EntraBetaUserThumbnailPhoto

## Synopsis
Retrieve the thumbnail photo of a user

## Syntax

```powershell
Get-EntraBetaUserThumbnailPhoto
 -ObjectId <String>
 [-FileName <String>]
 [-FilePath <String>]
 [-View <Boolean>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description
Retrieve the thumbnail photo of a user

## Examples

### Example 1
```
PS C:\WINDOWS\system32> Get-EntraBetaUserThumbnailPhoto -ObjectId df19e8e6-2ad7-453e-87f5-037f6529ae16


Tag                  :
PhysicalDimension    : {Width=279, Height=390}
Size                 : {Width=279, Height=390}
Width                : 279
Height               : 390
HorizontalResolution : 96
VerticalResolution   : 96
Flags                : 77840
RawFormat            : [ImageFormat: b96b3cae-0728-11d3-9d7b-0000f81ef32e]
PixelFormat          : Format24bppRgb
Palette              : System.Drawing.Imaging.ColorPalette
FrameDimensionsList  : {7462dc86-6180-4c7e-8e3f-ee7333a7a483}
PropertyIdList       : {11, 274, 305, 306...}
PropertyItems        : {11, 274, 305, 306...}
```

This example shows how to retrieve the thumbnail photo of a user that is specified through the value of the ObejctId parameter

## Parameters

### -FileName
If specified, a copy of the thumbnail photo is written to the specified file name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -FilePath
If specified, a copy of the thumbnail photo is written to the specified file path with a random name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
The object ID of the user for which the thumbnail photo is retrieved

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

### -View
If true, view the photo on the screen in a new window

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String
System.Boolean

## Outputs

### System.Object
## Notes

## Related Links
