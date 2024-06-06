---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaDeviceRegisteredUser

## SYNOPSIS
Gets a registered user.

## SYNTAX

```
Get-EntraBetaDeviceRegisteredUser -ObjectId <String> [-All] [-Top <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaDeviceRegisteredUser cmdlet gets a registered user for an Azure Active Directory device.

## EXAMPLES

### Example 1: Retrieve the registered users of a device
```
PS C:\> $DevId = (Get-EntraBetaDevice -Top 1).ObjectId
PS C:\> Get-EntraBetaDeviceRegisteredUser -ObjectId $DevId
```

The first command gets the object ID of a device by using the Get-EntraBetaDevice (./Get-EntraBetaDevice.md)cmdlet, and then stores it in the $DevId variable.
The second command gets the registered users of the device in $DevId.

## PARAMETERS

### -All
List all pages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
Specifies an object ID.

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

[Add-EntraBetaDeviceRegisteredUser]()

[Remove-EntraBetaDeviceRegisteredUser]()

