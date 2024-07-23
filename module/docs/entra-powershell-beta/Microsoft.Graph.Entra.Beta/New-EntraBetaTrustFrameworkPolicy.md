---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaTrustFrameworkPolicy

schema: 2.0.0
---

# New-EntraBetaTrustFrameworkPolicy

## Synopsis
This cmdlet is used to create a trust framework policy (custom policy) in the directory.

## Syntax

### Content (Default)
```
New-EntraBetaTrustFrameworkPolicy -Content <String> [-OutputFilePath <String>] [<CommonParameters>]
```

### File
```
New-EntraBetaTrustFrameworkPolicy -InputFilePath <String> [-OutputFilePath <String>] [<CommonParameters>]
```

## Description
This cmdlet is used to create a trust framework policy in the directory.

The contents of the trust framework policy to be created can be provided using a file or a command line variable.

The contents of the created trust framework policy can be written to an output file or to the screen.

## Examples

### Example 1
```
PS C:\> $policyContent = Get-Content 'C:\temp\CreatedPolicy.xml' | out-string
PS C:\> New-EntraBetaTrustFrameworkPolicy -Content $policyContent
```

The example creates a trust framework policy from the content specified.

The contents of newly created trust framework policy are displayed on screen.

### Example 2
```
PS C:\> $policyContent = Get-Content 'C:\temp\CreatedPolicy.xml' | out-string
PS C:\> New-EntraBetaTrustFrameworkPolicy -Content $policyContent -OutputFilePath C:\CreatedPolicy.xml
```

The example creates a trust framework policy from the content specified.

The contents of newly created trust framework policy are written to file mentioned in output file path.

### Example 3
```
PS C:\> New-EntraBetaTrustFrameworkPolicy -InputFilePath C:\InputPolicy.xml -OutputFilePath C:\CreatedPolicy.xml
```

The example creates a trust framework policy from the file mentioned in InputFilePath.

The contents of newly created trust framework policy are written to file mentioned in output file path.

### Example 4
```
PS C:\> New-EntraBetaTrustFrameworkPolicy -InputFilePath C:\InputPolicy.xml
```

The example creates a trust framework policy from the file mentioned in InputFilePath.

The contents of newly created trust framework policy are displayed on screen.

## Parameters

### -Content
The content of the trust framework policy to be created.

```yaml
Type: String
Parameter Sets: Content
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -InputFilePath
Path to the file used for reading the contents of trust framework policy to be created.

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -OutputFilePath
Path to the file used for writing the contents of newly created trust framework policy.

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

### System.String
## Outputs

### System.Object
## Notes

## Related Links
