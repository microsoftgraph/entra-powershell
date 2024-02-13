---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaDeviceRegisteredOwner

## SYNOPSIS
Removes the registered owner of a device.

## SYNTAX

```
Remove-EntraBetaDeviceRegisteredOwner -OwnerId <String> -ObjectId <String> [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraBetaDeviceRegisteredOwner cmdlet removes the registered owner of a device in Azure Active Directory (AD).

## EXAMPLES

### Example 1: Remove an owner from a device
```
PS C:\> $Device = Get-EntraBetaDevice -Top 1
PS C:\> $Owner = Get-EntraBetaDeviceRegisteredOwner -ObjectId $Device.ObjectId
PS C:\> Remove-EntraBetaDeviceRegisteredOwner -ObjectId $Device.ObjectId -OwnerId $Owner.ObjectId
```

The first command gets a device by using the Get-EntraBetaDevice (./Get-EntraBetaDevice.md)cmdlet, and then stores it in the $Device variable.

The second command gets the registered owner for the device in $Device by using the Get-EntraBetaDeviceRegisteredOwner (./Get-EntraBetaDeviceRegisteredOwner.md)cmdlet.
The command stores it in the $Owner variable.

The final command removes the owner in $Owner from the device in $Device.

## PARAMETERS

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

### -OwnerId
Specifies an owner ID.

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

[Add-EntraBetaDeviceRegisteredOwner]()

[Get-EntraBetaDevice]()

[Get-EntraBetaDeviceRegisteredOwner]()

