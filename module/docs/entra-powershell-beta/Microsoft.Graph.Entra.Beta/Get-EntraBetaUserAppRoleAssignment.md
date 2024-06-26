---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaUserAppRoleAssignment

## Synopsis
get a user application role assignment.

## Syntax

```
Get-EntraBetaUserAppRoleAssignment -ObjectId <String> [-All] [-Top <Int32>] [<CommonParameters>]
```

## Description

## Examples

### Example 1: Get a user application role assignment
```
PS C:\> $UserId = (Get-EntraBetaUser -Top 1).ObjectId
Get-EntraBetaUserAppRoleAssignment -ObjectId $UserId
```

The first command gets the ID of an Azure AD user by using the Get-EntraBetaUser (./Get-EntraBetaUser.md)cmdlet. 
The command stores the value in the $UserId variable.

The second command gets a user application role assignment for the user in $UserId.

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of a user (as a UPN or ObjectId) in Azure Active Directory.

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

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
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

[New-EntraBetaUserAppRoleAssignment]()

[Remove-EntraBetaUserAppRoleAssignment]()