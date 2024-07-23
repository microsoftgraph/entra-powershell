---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaApplicationVerifiedPublisher

schema: 2.0.0
---

# Set-EntraBetaApplicationVerifiedPublisher

## Synopsis
Sets the verified publisher of an application to a verified Microsoft Partner Network (MPN) identifier.

## Syntax

```
Set-EntraBetaApplicationVerifiedPublisher -SetVerifiedPublisherRequest <SetVerifiedPublisherRequest>
 -AppObjectId <String> [<CommonParameters>]
```

## Description
Sets the verified publisher of an application to a verified Microsoft Partner Network (MPN) identifier.

## Examples

### Example 1: Set the verified publisher of an application.
```
$appObjId = 'ad6c71a5-e48f-4320-bb59-92642a2d8d9f'
          $mpnId =  '0433167'
          $req =  @{verifiedPublisherId=$mpnId}
          Set-EntraBetaApplicationVerifiedPublisher -AppObjectId $appObjId -SetVerifiedPublisherRequest $req
```

## Parameters

### -AppObjectId
The unique identifier of an Azure Active Directory Application object.

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

## Inputs

### string
### string
## Outputs

## Notes

## Related Links

[Remove-EntraBetaApplicationVerifiedPublisher]()

