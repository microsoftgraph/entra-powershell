---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Add-EntraBetaAdministrativeUnitMember

## SYNOPSIS
Adds an administrative unit member.

## SYNTAX

```
Add-EntraBetaAdministrativeUnitMember -RefObjectId <String> -ObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Add-EntraBetaAdministrativeUnitMember cmdlet adds an Active Directory administrative unit member.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ObjectId
Specifies the ID of an Active Directory administrative unit.

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
Specifies the unique ID of the specific Azure Active Directory object that will be assigned as owner/manager/member.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaAdministrativeUnitMember]()

[Remove-EntraBetaAdministrativeUnitMember]()

