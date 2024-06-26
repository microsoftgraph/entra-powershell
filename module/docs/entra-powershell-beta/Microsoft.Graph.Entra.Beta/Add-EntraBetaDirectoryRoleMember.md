---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Add-EntraBetaDirectoryRoleMember

## Synopsis
adds a member to a directory role.

## Syntax

```
Add-EntraBetaDirectoryRoleMember -ObjectId <String> -RefObjectId <String>
 [<CommonParameters>]
```

## Description
the Add-EntraBetaDirectoryRoleMember cmdlet adds a member to an Azure Active Directory role.

## Examples

### Example 1: Add a member to an Active Directory role
```
PS C:\>Add-EntraBetaDirectoryRoleMember -ObjectId 019ea7a2-1613-47c9-81cb-20ba35b1ae48 -RefObjectId c13dd34a-492b-4561-b171-40fcce2916c5
```

This command adds a member to an Active Directory role.

## Parameters



### -ObjectId
Specifies the ID of a directory role in Azure Active Directory.

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
Specifies the ID of the Azure Active Directory object to assign as owner/manager/member.

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

[Get-EntraBetaDirectoryRoleMember]()

[Remove-EntraBetaDirectoryRoleMember]()

