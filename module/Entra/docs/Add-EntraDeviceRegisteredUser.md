---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraDeviceRegisteredUser

## SYNOPSIS
Adds a registered user for a device.

## SYNTAX

```
Add-EntraDeviceRegisteredUser -ObjectId <String> -RefObjectId <String> [<CommonParameters>]
```

## DESCRIPTION
The Add-EntraDeviceRegisteredUser cmdlet adds a registered user for a Microsoft Entra ID device.

## EXAMPLES

### Example 1: Add a user as a registered user
```
PS C:\> $User = Get-EntraUser -Top 1
PS C:\> $Device = Get-EntraDevice -Top 1
PS C:\> Add-EntraDeviceRegisteredUser -ObjectId $Device.ObjectId -RefObjectId $User.ObjectId
```

The first command gets a user by using the Get-EntraUser (./Get-EntraUser.md)cmdlet, and then stores it in the $User variable.

The second command gets a device by using the Get-EntraDevice (./Get-EntraDevice.md)cmdlet, and then stores it in the $Device variable.

The final command adds the user in $User as the registered user for the device in $Device. 
Both parameters use the ObjectId property of specified object.

## PARAMETERS

### -ObjectId
@{Text=}

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

### -RefObjectId
@{Text=}

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraDevice]()

[Get-EntraDeviceRegisteredUser]()

[Get-EntraUser]()

[Remove-EntraDeviceRegisteredUser]()

