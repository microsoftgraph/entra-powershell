---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Set-EntraBetaUserThumbnailPhoto

## Synopsis
Set the thumbnail photo for a user

## Syntax

### File (Default)
```
Set-EntraBetaUserThumbnailPhoto [-ObjectId <String>] -FilePath <String> [<CommonParameters>]
```

### ByteArray
```
Set-EntraBetaUserThumbnailPhoto [-ObjectId <String>] -ImageByteArray <Byte[]> [<CommonParameters>]
```

### Stream
```
Set-EntraBetaUserThumbnailPhoto [-ObjectId <String>] -FileStream <Stream> [<CommonParameters>]
```

## Description
This cmdlet is used to set the thumbnail photo for a user

## Examples

### Example 1
```
PS C:\WINDOWS\system32> Set-EntraBetaUserThumbnailPhoto -ObjectId ba6752c4-6a2e-4be5-a23d-67d8d5980796 -FilePath D:\UserThumbnailPhoto.jpg
```

This example sets the thumbnail photo of the user specified witht eh PObjectId parameter to the image specified with the FilePath parameter

## Parameters

### -FilePath
The file path of the image to be uploaded as the user thumbnail photo

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -FileStream
A filestream that contains the user thumbnail photo

```yaml
Type: Stream
Parameter Sets: Stream
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ImageByteArray
An Image Byte Array that contains the user thumbnail photo

```yaml
Type: Byte[]
Parameter Sets: ByteArray
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
The Object ID of the user for which the user thumbnail photo is set

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String
System.IO.Stream System.Byte\[\]

## Outputs

### System.Object
## Notes

## Related Links
