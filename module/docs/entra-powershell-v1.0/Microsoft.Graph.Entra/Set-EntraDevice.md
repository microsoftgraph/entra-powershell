---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraDevice

## SYNOPSIS
Updates a device.

## SYNTAX

```
Set-EntraDevice [-DevicePhysicalIds <System.Collections.Generic.List`1[System.String]>]
 [-DeviceOSType <String>] [-DeviceTrustType <String>] [-DisplayName <String>] [-DeviceMetadata <String>]
 -ObjectId <String> [-ApproximateLastLogonTimeStamp <DateTime>] [-AccountEnabled <Boolean>]
 [-IsManaged <Boolean>] [-DeviceId <String>] [-DeviceObjectVersion <Int32>] [-IsCompliant <Boolean>]
 [-DeviceOSVersion <String>]
 [-AlternativeSecurityIds <System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AlternativeSecurityId]>]
 [-ProfileType <String>] [-SystemLabels <System.Collections.Generic.List`1[System.String]>]
 [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraDevice cmdlet updates a device in Microsoft Entra ID.

## EXAMPLES

### Example 1: Update a device
```
PS C:\>Set-EntraDevice -ObjectId "99a1915d-298f-42d1-93ae-71646b85e2fa" -DisplayName "My OS/2 computer"
```

This command updates the specified device.

## PARAMETERS

### -AccountEnabled
Indicates whether the account is enabled.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlternativeSecurityIds
Specifies alternative security IDs.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.AzureAD.Model.AlternativeSecurityId]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApproximateLastLogonTimeStamp
@{Text=}

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceId
Specifies the device ID.

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

### -DeviceMetadata
The device metadata for this device

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

### -DeviceObjectVersion
Specifies the object version of the device.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceOSType
Specifies the operating system.

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

### -DeviceOSVersion
Specifies the operating sytem version.

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

### -DevicePhysicalIds
Specifies the physical ID.

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

### -DeviceTrustType
The device trust type

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

### -DisplayName
Specifies the display name.

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

### -IsCompliant
Indicates whether the device is compliant.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsManaged
Indicates whether the device is managed.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
Specifies the object ID of a device in Azure AD.

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

### -ProfileType
{{ Fill ProfileType Description }}

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

### -SystemLabels
{{ Fill SystemLabels Description }}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraDevice]()

[New-EntraDevice]()

[Remove-EntraDevice]()

