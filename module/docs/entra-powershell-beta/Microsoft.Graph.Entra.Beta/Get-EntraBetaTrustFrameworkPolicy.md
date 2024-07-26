---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaTrustFrameworkPolicy

schema: 2.0.0
---

# Get-EntraBetaTrustFrameworkPolicy

## Synopsis
This cmdlet is used to retrieve the created trust framework policies (custom policies) in the directory.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaTrustFrameworkPolicy
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaTrustFrameworkPolicy
 -Id <String>
 [-OutputFilePath <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description
This cmdlet is used to retrieve the trust framework policies that have been created in the directory.

## Examples

### Example 1
```
PS C:\> Get-EntraBetaTrustFrameworkPolicy
```

This example retrieves the list of all trust framework policies in the directory.

### Example 2
```
PS C:\> Get-EntraBetaTrustFrameworkPolicy -Id B2C_1A_signup_signin
```

This example retrieves the contents of the specified trust framework policy.

## Parameters

### -Id
The unique identifier for a trust framework policy.

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -OutputFilePath
@{Description=System.Management.Automation.PSObject\[\]}

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
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

### System.String
## Outputs

### System.Object
## Notes

## Related Links
