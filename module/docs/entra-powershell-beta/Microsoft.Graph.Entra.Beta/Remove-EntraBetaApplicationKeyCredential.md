---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaApplicationKeyCredential

## Synopsis
Removes a key credential from an application.

## Syntax

```
Remove-EntraBetaApplicationKeyCredential -ObjectId <String> -KeyId <String>[<CommonParameters>]
```

## Description
The Remove-EntraBetaApplicationKeyCredential cmdlet removes a key credential from an application.

## Examples

### Example 1: Remove a key credential
```
PS C:\> Remove-EntraBetaApplicationKeyCredential -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -KeyId "6aa971c6-3040-45df-87ed-581c8c09ff2b"
```

This command removes the specified key credential from the specified application.

## Parameters


### -KeyId
Specifies a custom key ID.

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

### -ObjectId
Specifies a unique ID of an application in Azure Active Directory.

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

[Get-EntraBetaApplicationKeyCredential]()

[New-EntraBetaApplicationKeyCredential]()

