---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaServiceAppRoleAssignment

schema: 2.0.0
---

# New-EntraBetaServiceAppRoleAssignment

## Synopsis
Assigns a service principal to an application role.

## Syntax

```
New-EntraBetaServiceAppRoleAssignment -ResourceId <String> -Id <String> -ObjectId <String>
 -PrincipalId <String> 
 [<CommonParameters>]
```

## Description
The New-EntraBetaServiceAppRoleAssignment cmdlet assigns a service principal to an application role in Azure Active Directory (AD).

## Examples

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## Parameters

### -Id
Specifies the ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```



### -ObjectId
Specifies the ID of a service principal in Azure AD.

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

### -PrincipalId
Specifies a principal ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
Specifies a resource ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaServiceAppRoleAssignment]()

[Remove-EntraBetaServiceAppRoleAssignment]()

