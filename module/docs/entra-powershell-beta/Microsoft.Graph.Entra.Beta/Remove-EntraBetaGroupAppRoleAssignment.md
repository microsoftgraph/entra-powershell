---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaGroupAppRoleAssignment

schema: 2.0.0
---

# Remove-EntraBetaGroupAppRoleAssignment

## Synopsis
Delete a group application role assignment.

## Syntax

```
Remove-EntraBetaGroupAppRoleAssignment -ObjectId <String> -AppRoleAssignmentId <String>
 [<CommonParameters>]
```

## Description
The Remove-EntraBetaGroupAppRoleAssignment cmdlet removes a group application role assignment from Azure Active Directory (AD).

## Examples

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## Parameters

### -AppRoleAssignmentId
Specifies the object ID of the group application role assignment.

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
Specifies the object ID of a group in Azure AD.

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

[Get-EntraBetaGroupAppRoleAssignment]()

[New-EntraBetaGroupAppRoleAssignment]()

