---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Set-EntraBetaAdministrativeUnit

## Synopsis
updates an administrative unit.

## Syntax

```
Set-EntraBetaAdministrativeUnit [-MembershipType <String>] -Id <String> [-MembershipRule <String>]
 [-IsMemberManagementRestricted <Boolean>] [-Description <String>] [-MembershipRuleProcessingState <String>]
 [-DisplayName <String>] 
 [<CommonParameters>]
```

## Description
the Set-EntraBetaAdministrativeUnit cmdlet updates an administrative unit in Azure Active Directory (AD).

## Examples

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## Parameters

### -Description
Specifies a description.

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

### -DisplayName
Specifies a display name.

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

### -IsMemberManagementRestricted
Indicates whether the management rights on resources in the administrative units should be restricted to ONLY the administrators scoped on the AU object.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```



### -Id
Specifies the ID of an administrative unit in Azure AD.

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

### -MembershipRule
{{ Fill MembershipRule Description }}

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

### -MembershipRuleProcessingState
{{ Fill MembershipRuleProcessingState Description }}

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

### -MembershipType
{{ Fill MembershipType Description }}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaAdministrativeUnit]()

[New-EntraBetaAdministrativeUnit]()

[Remove-EntraBetaAdministrativeUnit]()
