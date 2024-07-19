---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaApplicationPasswordCredential

## Synopsis
Removes a password credential from an application.

## Syntax

```
Remove-EntraBetaApplicationPasswordCredential -ObjectId <String> -KeyId <String>
 [<CommonParameters>]
```

## Description
The Remove-EntraBetaApplicationPasswordCredential cmdlet removes a password credential from an application in Azure Active Directory (AD).

## Examples

### Example 1: Remove an application password credential
```
PS C:\> $AppID = (Get-EntraBetaApplication -Top 1).ObjectId
PS C:\> $KeyIDs = Get-EntraBetaApplicationPasswordCredential -ObjectId $AppId
PS C:\> Remove-EntraBetaApplicationPasswordCredential -ObjectId $AppId -KeyId $KeyIds[0].KeyId
```

The first command gets the ID of an application by using the Get-EntraBetaApplication (./Get-EntraBetaApplication.md)cmdlet, and then stores it in the $AppID variable.

The second command gets the password credential for the application identified by $AppID by using the Get-EntraBetaApplicationPasswordCredential (./ Get-EntraBetaApplicationPasswordCredential.md)cmdlet. 
The command stores it in the $KeyId variable.

The final command removes the application password credential for the application identified by $AppID.

## Parameters


### -KeyId
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

### -ObjectId
Specifies the ID of the application in Azure AD.

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

[Get-EntraBetaApplication]()

[Get-EntraBetaApplicationPasswordCredential]()

[Remove-EntraBetaApplicationPasswordCredential]()

