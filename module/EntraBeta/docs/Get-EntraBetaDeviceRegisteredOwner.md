---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaDeviceRegisteredOwner

## SYNOPSIS
Gets the registered owner of a device.

## SYNTAX

```
Get-EntraBetaDeviceRegisteredOwner -ObjectId <String> [-All <Boolean>] [-Top <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaDeviceRegisteredOwner cmdlet gets the registered owner of a device in Azure Active Directory.

## EXAMPLES

### Example 1: Retrieve the registered owner of a device
```
PS C:\> $DevId = (Get-EntraBetaDevice -Top 1).ObjectId
PS C:\> Get-EntraBetaDeviceRegisteredOwner -ObjectId $DevId
```

The first command gets the object ID of a device by using the Get-EntraBetaDevice (./Get-EntraBetaDevice.md)cmdlet, and then stores it in the $DevId variable.
The second command gets the registered owner of the device in $DevId.

## PARAMETERS

### -All
If true, return all registered owners.
If false, return the number of objects specified by the Top parameter

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

### -Top
@{Text=}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaDeviceRegisteredOwner]()

[Get-EntraBetaDevice]()

[Remove-EntraBetaDeviceRegisteredOwner]()

