---
external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Test-EntraScript

## SYNOPSIS
Checks, whether the provided script is using AzureAD commands that are not supported by Microsoft.Graph.Entra.

## SYNTAX

```
Test-EntraScript [-Path] <String[]> [[-Content] <String>] [-Quiet] [<CommonParameters>]
```

## DESCRIPTION
Checks, whether the provided script is using AzureAD commands that are not supported by Microsoft.Graph.Entra.

## EXAMPLES

### EXAMPLE 1
```
Test-EntraScript -Path .\usercreation.ps1 -Quiet
```

Returns whether the script "usercreation.ps1" could run under Microsoft.Graph.Entra

### EXAMPLE 2
```
Get-ChildItem -Path \\contoso.com\it\code -Recurse -Filter *.ps1 | Test-EntraScript
```

Returns a list of all scripts that would not run under the Microsoft.Graph.Entra module, listing each issue with line and code.

## PARAMETERS

### -Path
Path to the script file(s) to scan.
Or name of the content, when also specifying -Content

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: FullName, Name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Content
Code content to scan.
Used when scanning code that has no file representation (e.g.
straight from a repository).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Quiet
Only return $true or $false, based on whether the script could run under Microsoft.Graph.Entra ($true) or not ($false)

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
