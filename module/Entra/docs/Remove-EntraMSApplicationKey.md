---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSApplicationKey

## SYNOPSIS
Removes a key from an application.

## SYNTAX

```
Remove-EntraMSApplicationKey -ObjectId <String> [-Proof <String>] [-KeyId <String>] [<CommonParameters>]
```

## DESCRIPTION
Removes a key from an application.

## EXAMPLES

### Example 1: Removes a key credential from an application
```
PS C:\>Remove-EntraMSApplicationKey -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -KeyId "FDA27CF-1B58-4CAE-8CE7-CD04F0AAB945" -Proof {token}
```

This command removes the specificed key credential from the specified application.

## PARAMETERS

### -ObjectId
The unique identifier of the object specific Microsoft Entra ID object

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

### -KeyId
The key id corresponding to the key object to be removed.

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

### -Proof
The JWT token provided as a proof of possession.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### string
## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraMSApplicationKey]()

