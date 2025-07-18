---
title: Get-EntraBetaApplicationOwner
description: This article provides details on the Get-EntraBetaApplicationOwner command.


ms.topic: reference
ms.date: 08/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaApplicationOwner

schema: 2.0.0
---

# Get-EntraBetaApplicationOwner

## Synopsis

Gets the owner of an application.

## Syntax

```powershell
Get-EntraBetaApplicationOwner
 -ApplicationId <String>
 [-Top <Int32>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaApplicationOwner` cmdlet get an owner of an Microsoft Entra ID application.

## Examples

### Example 1: Get the owner of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$Application = Get-EntraBetaApplication -SearchString '<application-name>'
Get-EntraBetaApplicationOwner -ApplicationId $Application.ObjectId
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
dddddddd-3333-4444-5555-eeeeeeeeeeee
eeeeeeee-4444-5555-6666-ffffffffffff
```

This example demonstrates how to get the owners of an application in Microsoft Entra ID.

- `-ApplicationId` parameter specifies the unique identifier of an application.

### Example 2: Get the details about the owner of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$application = Get-EntraBetaApplication -SearchString '<application-name>'
$applicationOwners = Get-EntraBetaApplicationOwner -ObjectId $application.ObjectId
$ownerDetails = $applicationOwners | ForEach-Object {
    $ownerDetail = Get-EntraBetaObjectByObjectId -ObjectIds $_.Id
    [PSCustomObject]@{
        displayName      = $ownerDetail.displayName
        Id               = $ownerDetail.Id
        UserPrincipalName = $ownerDetail.UserPrincipalName
        UserType         = $ownerDetail.UserType
        accountEnabled   = $ownerDetail.accountEnabled
    }
}
$ownerDetails | Format-Table -Property displayName, Id, UserPrincipalName, UserType, accountEnabled -AutoSize
```

```Output
displayName    Id                                   UserPrincipalName             UserType accountEnabled
-----------    --                                   -----------------             -------- --------------
Sawyer Miller  bbbbbbbb-1111-2222-3333-cccccccccccc SawyerM@contoso.com           Member   True
Adele Vance    ec5813fb-346e-4a33-a014-b55ffee3662b AdeleV@contoso.com            Member   True
```

This example demonstrates how to get the owners of an application in Microsoft Entra ID with more owner lookup details.

### Example 3: Get all owners of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$Application = Get-EntraBetaApplication -SearchString '<application-name>'
Get-EntraBetaApplicationOwner -ApplicationId $Application.ObjectId -All
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
dddddddd-3333-4444-5555-eeeeeeeeeeee
eeeeeeee-4444-5555-6666-ffffffffffff
```

This example demonstrates how to get the all owners of a specified application in Microsoft Entra ID.

- `-ApplicationId` parameter specifies the unique identifier of an application.

### Example 4: Get top two owners of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$Application = Get-EntraBetaApplication -SearchString '<application-name>'
Get-EntraBetaApplicationOwner -ApplicationId $Application.ObjectId -Top 2
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
```

This example demonstrates how to get the two owners of a specified application in Microsoft Entra ID.

- `-ApplicationId` parameter specifies the unique identifier of an application.

## Parameters

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationId

Specifies the ID of an application in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraBetaApplicationOwner](Add-EntraBetaApplicationOwner.md)

[Remove-EntraBetaApplicationOwner](Remove-EntraBetaApplicationOwner.md)
