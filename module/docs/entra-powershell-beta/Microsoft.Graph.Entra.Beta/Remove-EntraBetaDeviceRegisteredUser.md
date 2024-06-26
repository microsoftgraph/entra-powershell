---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaDeviceRegisteredUser

## Synopsis
Removes a registered user from a device.

## Syntax

```
Remove-EntraBetaDeviceRegisteredUser -ObjectId <String> -UserId <String> [<CommonParameters>]
```

## Description
The Remove-EntraBetaDeviceRegisteredUser cmdlet removes a registered user from an Azure Active Directory device.

## Examples

### Example 1: Remove a registered user from a device
```
PS C:\> $Device = Get-EntraBetaDevice -Top 1
PS C:\> $User = Get-EntraBetaDeviceRegisteredUser -ObjectId $Device.ObjectId
PS C:\> Remove-EntraBetaDeviceRegisteredOwner -ObjectId $Device.ObjectId -OwnerId $Owner.ObjectId
```

The first command gets a device by using the Get-EntraBetaDevice (./Get-EntraBetaDevice.md)cmdlet, and then stores it in the $Device variable.

The second command gets the registered user for the device in $Device by using the Get-EntraBetaDeviceRegisteredUser (./Get-EntraBetaDeviceRegisteredUser.md)cmdlet.
The command stores it in the $User variable.

The final command removes the user in $User from the device in $Device.

## Parameters

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

### -UserId
Specifies the ID of a user.

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

## Outputs

## Notes

## Related LINKS

[Add-EntraBetaDeviceRegisteredUser]()

[Get-EntraBetaDeviceRegisteredUser]()

