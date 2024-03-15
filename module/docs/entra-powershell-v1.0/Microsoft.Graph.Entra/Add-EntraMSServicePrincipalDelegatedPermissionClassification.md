---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraMSServicePrincipalDelegatedPermissionClassification

## SYNOPSIS
Add a classification for a delegated permission.

## SYNTAX

```
Add-EntraMSServicePrincipalDelegatedPermissionClassification -PermissionId <String>
 -Classification <ClassificationEnum> -PermissionName <String> -ServicePrincipalId <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Add-EntraMSServicePrincipalDelegatedPermissionClassification cmdlet creates a delegated permission classification for the given permission on service principal.

## EXAMPLES

### Example 1: Create Delegated Permission Classification
```
PS C:\> Add-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "95f56359-0165-4f80-bffb-c89d06cf2c6f" -PermissionId "205e70e5-aba6-4c52-a976-6d2d46c48043" -Classification Low -PermissionName "Sites.Read.All"

Classification : Low
Id             : 5XBeIKarUkypdm0tRsSAQwE
PermissionId   : 205e70e5-aba6-4c52-a976-6d2d46c48043
PermissionName : Sites.Read.All
```

This command creates a delegated permission classification for the given permission on the service principal.

## PARAMETERS

### -ServicePrincipalId
The unique identifier of a service principal object in Microsoft Entra ID.

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

### -PermissionId
The id for a delegated permission.

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

### -PermissionName
The name for a delegated permission.

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

### -Classification
The classification for a delegated permission.
This parameter can take one of the following values:

* "Low" - Specifies a classification for a permission as low impact.
* "Medium" - Specifies a classification for a permission as medium impact.
* "High" - Specifies a classification for a permission as high impact.

```yaml
Type: ClassificationEnum
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Online.Administration.DelegatedPermissionClassification
## NOTES
## RELATED LINKS
