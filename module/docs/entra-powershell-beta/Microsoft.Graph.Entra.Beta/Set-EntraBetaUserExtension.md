---
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Set-EntraBetaUserExtension

## Synopsis
Sets a user extension.

## Syntax

### SetSingle
```
Set-EntraBetaUserExtension -ExtensionName <String> -ObjectId <String> -ExtensionValue <String>
 [<CommonParameters>]
```

### SetMultiple
```
Set-EntraBetaUserExtension -ObjectId <String>
 -ExtensionNameValues <System.Collections.Generic.Dictionary`2[System.String,System.String]>
 [<CommonParameters>]
```

## Description
The Set-EntraBetaUserExtension cmdlet sets a user extension in Azure Active Directory (Azure AD).

## Examples

### Example 1: Set the value of an extension attribute for a user
```
PS C:\> $User = Get-EntraBetaUser -Top 1
PS C:\> Set-EntraBetaUserExtension -ObjectId $User.ObjectId -ExtensionName extension_e5e29b8a85d941eab8d12162bd004528_extensionAttribute8 -ExtensionValue "New Value"
```

The first command gets a user by using the Get-EntraBetaUser (./Get-EntraBetaUser.md)cmdlet, and then stores it in the $User variable.

The second command  sets the value of the extension attribute that hast he specified name to the value New Value.
You can get extension attribute names by using the Get-AzureAdExtensionProperty (./Get-AzureAdExtensionProperty.md)cmdlet.

## Parameters

### -ExtensionName
Specifies the name of an extension.

```yaml
Type: String
Parameter Sets: SetSingle
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExtensionNameValues
Specifies extension name values.

```yaml
Type: System.Collections.Generic.Dictionary`2[System.String,System.String]
Parameter Sets: SetMultiple
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExtensionValue
Specifies an extension value.

```yaml
Type: String
Parameter Sets: SetSingle
Aliases:

Required: True
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaUser]()

[Get-EntraBetaUserExtension]()

[Get-AzureAdExtensionProperty]()

[Remove-EntraBetaUserExtension]()

