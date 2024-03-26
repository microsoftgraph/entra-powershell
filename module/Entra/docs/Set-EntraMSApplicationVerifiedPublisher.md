---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraMSApplicationVerifiedPublisher

## SYNOPSIS
Sets the verified publisher of an application to a verified Microsoft Partner Network (MPN) identifier.

## SYNTAX

```
Set-EntraMSApplicationVerifiedPublisher -AppObjectId <String>
 -SetVerifiedPublisherRequest <SetVerifiedPublisherRequest> [<CommonParameters>]
```

## DESCRIPTION
Sets the verified publisher of an application to a verified Microsoft Partner Network (MPN) identifier.

## EXAMPLES

### Example 1: Set the verified publisher of an application.
```
$appObjId = 'ad6c71a5-e48f-4320-bb59-92642a2d8d9f'
          $mpnId =  '0433167'
          $req =  @{verifiedPublisherId=$mpnId}
          Set-EntraMSApplicationVerifiedPublisher -AppObjectId $appObjId -SetVerifiedPublisherRequest $req
```

## PARAMETERS

### -AppObjectId
The unique identifier of a Microsoft Entra ID Application object.

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

### -SetVerifiedPublisherRequest
A request body object containing the verifiedPublisherId property its the MPNID value.

```yaml
Type: SetVerifiedPublisherRequest
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

### string
### string
## OUTPUTS

## NOTES

## RELATED LINKS

[Remove-EntraMSApplicationVerifiedPublisher]()

