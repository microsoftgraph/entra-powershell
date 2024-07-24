---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Add-EntraBetaServicePrincipalOwner

schema: 2.0.0
---

# Add-EntraBetaServicePrincipalOwner

## Synopsis
Adds an owner to a service principal.

## Syntax

```
Add-EntraBetaServicePrincipalOwner -ObjectId <String> -RefObjectId <String>
 [<CommonParameters>]
```

## Description
The Add-EntraBetaServicePrincipalOwner cmdlet adds an owner to a service principal in Azure Active Directory.

## Examples

### Example 1: Add a user as an owner to a service principal
```
PS C:\> $ServicePrincipalId = (Get-EntraBetaServicePrincipal -Top 1).ObjectId
PS C:\> $OwnerId = (Get-EntraBetaUser -Top 1).ObjectId
PS C:\> Add-EntraBetaServicePrincipalOwner -ObjectId $ServicePrincipalId -RefObjectId -$OwnerId
```

The first command gets the object ID of a service principal by using the Get-EntraBetaServicePrincipal (./Get-EntraBetaServicePrincipal.md)cmdlet, and then stores it in the $ServicePrincipalId variable.

The second command gets the object ID a user by using the Get-EntraBetaUser (./Get-EntraBetaUser.md)cmdlet, and then stores it in the $OwnerId variable.

The final command adds the user specified by $OwnerId an owner to a service principal specified by $ServicePrincipalId.

## Parameters



### -ObjectId
Specifies the ID of a service principal in Active Directory.

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
Specifies the ID of the Active Directory object to assign as owner/manager/member.

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

[Get-EntraBetaServicePrincipal]()

[Get-EntraBetaServicePrincipalOwner]()

[Get-EntraBetaUser]()

[Remove-EntraBetaServicePrincipalOwner]()

