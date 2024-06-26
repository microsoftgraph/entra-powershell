---
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Select-EntraBetaGroupIdsContactIsMemberOf

## Synopsis
Get groups in which a contact is a member.

## Syntax

```
Select-EntraBetaGroupIdsContactIsMemberOf -ObjectId <String>
 -GroupIdsForMembershipCheck <GroupIdsForMembershipCheck> [<CommonParameters>]
```

## Description
The Select-EntraBetaGroupIdsContactIsMemberOf cmdlet gets groups in Azure Active Directory (AD) in which a contact is a member.

## Examples

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## Parameters

### -GroupIdsForMembershipCheck
Specifies an array of group object IDs.

```yaml
Type: GroupIdsForMembershipCheck
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies the object ID of a contact in Azure AD.

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
