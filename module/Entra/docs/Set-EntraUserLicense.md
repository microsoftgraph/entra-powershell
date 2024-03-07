---
title: Set-EntraUserLicense
description: This article provides details on the Set-EntraUserLicense command.

ms.service: active-directory
ms.topic: reference
ms.date: 02/28/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraUserLicense

## SYNOPSIS
Adds or removes licenses for a Microsoft online service to the list of assigned licenses for a user.

## SYNTAX

```powershell
Set-EntraUserLicense 
    -ObjectId <String>
    -AssignedLicenses <AssignedLicenses> 
    [-InformationAction <ActionPreference>] 
    [-InformationVariable <String>] 
    [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraUserLicense adds or removes licenses for a Microsoft online service to the list of assigned licenses for a user.

## EXAMPLES

### Example 1: Add a license to a user based on a template user
This example shows how to add a license to a user.

```powershell
PS C:\> $LicensedUser = Get-EntraUser -ObjectId "TemplateUser@contoso.com"  
PS C:\> $User = Get-EntraUser -ObjectId "User@contoso.com"  
PS C:\> $License = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense 
PS C:\> $License.SkuId = $LicensedUser.AssignedLicenses.SkuId 
PS C:\> $Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses 
PS C:\> $Licenses.AddLicenses = $License 
PS C:\> Set-EntraUserLicense -ObjectId $User.ObjectId -AssignedLicenses $Licenses
```

The first command gets a user by using the Get-EntraUser (./Get-EntraUser.md)cmdlet, and then stores it in the $LicensedUser variable.

The second command gets another user by using Get-EntraUser , and then stores it in the $User variable.

The third command creates an AssignedLicense type, and then stores it in the $License variable.

The fourth command set the SkuId property of $License to the same value as the SkuId property of $LicensedUser.

The fifth commmand creates an AssignedLicenses object, and stores it in the $Licenses variable.

The sixth command adds the license in $License to $Licenses.

The final command assigns the licenses in $Licenses to the user in $User.
The licenses in $Licenses includes $License from the third and fourth commands.

## PARAMETERS

### -AssignedLicenses
Specifies a list of licenses to assign or remove.

```yaml
Type: AssignedLicenses
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -InformationAction
Specifies how this cmdlet responds to an information event.
The acceptable values for this parameter are:

- Continue
- Ignore
- Inquire
- SilentlyContinue
- Stop
- Suspend

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
Specifies an information variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of a user (as a UPN or ObjectId) in Microsoft Entra ID.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraUser](Get-EntraUser.md)

