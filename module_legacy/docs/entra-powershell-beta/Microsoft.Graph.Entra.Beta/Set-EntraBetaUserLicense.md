---
title: Set-EntraBetaUserLicense
description: This article provides details on the Set-EntraBetaUserLicense command.

ms.topic: reference
ms.date: 07/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaUserLicense

schema: 2.0.0
---

# Set-EntraBetaUserLicense

## Synopsis

Adds or removes licenses for a Microsoft online service to the list of assigned licenses for a user.

## Syntax

```powershell
Set-EntraBetaUserLicense
 -ObjectId <String>
 -AssignedLicenses <AssignedLicenses>
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaUserLicense` adds or removes licenses for a Microsoft online service to the list of assigned licenses for a user.

For delegated scenarios, the calling user needs at least one of the following Microsoft Entra roles.

- Directory Writers
- License Administrator
- User Administrator

**Note**: Before assigning a license, assign a usage location to the user using:
`Set-EntraUser -ObjectId user@contoso.com -UsageLocation '<two-letter-country-code e.g. GB/US>'`.

## Examples

### Example 1: Add a license to a user based on a template user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$LicensedUser = Get-EntraBetaUser -ObjectId 'TemplateUser@contoso.com' 
$License = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense 
$License.SkuId = $LicensedUser.AssignedLicenses.SkuId 
$Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses 
$Licenses.AddLicenses = $License 
$Params = @{
    ObjectId = 'SawyerM@contoso.com' 
    AssignedLicenses = $Licenses
}
Set-EntraBetaUserLicense @Params
```

```Output
Name                           Value
----                           -----
externalUserStateChangeDateTi…
businessPhones                 {8976546787}
postalCode                     444601
createdDateTime                06-11-2023 04:48:19
surname                        KTETSs
jobTitle                       Manager
employeeType
otherMails                     {SawyerM@contoso.com}
isResourceAccount
usageLocation                  DE
legalAgeGroupClassification    Adult
id                             cccccccc-2222-3333-4444-dddddddddddd
isLicenseReconciliationNeeded  False
```

This example demonstrates how to assign a license to a user based on a template user.

- `-ObjectId` parameter specifies the object Id of a user(as a UserPrincipalName or ObjectId).
- `-AssignedLicenses` parameter specifies a list of licenses to assign or remove.

### Example 2: Add a license to a user by copying license from another user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$LicensedUser = Get-EntraBetaUser -ObjectId 'AdeleV@contoso.com'
$User = Get-EntraBetaUser -ObjectId 'SawyerM@contoso.com' 
$License1 = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense 
$License1.SkuId = $LicensedUser.AssignedLicenses.SkuId[0] 
$License2 = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
$License2.SkuId = $LicensedUser.AssignedLicenses.SkuId[1]
$addLicensesArray = @()
$addLicensesArray += $License1
$addLicensesArray += $License2
$Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses 
$Licenses.AddLicenses = $addLicensesArray
$Params = @{
    ObjectId = $User.ObjectId 
    AssignedLicenses = $Licenses
}
Set-EntraBetaUserLicense @Params
```

```Output
Name                           Value
----                           -----
externalUserStateChangeDateTi…
businessPhones                 {8976546787}
postalCode                     444601
createdDateTime                06-11-2023 04:48:19
surname                        KTETSs
jobTitle                       Manager
employeeType
otherMails                     {SawyerM@contoso.com}
isResourceAccount
usageLocation                  DE
legalAgeGroupClassification    Adult
id                             cccccccc-2222-3333-4444-dddddddddddd
isLicenseReconciliationNeeded  False
```

This example demonstrates how to assign a license to a user by copying license from another user.

- `-ObjectId` parameter specifies the object Id of a user(as a UserPrincipalName or ObjectId).
- `-AssignedLicenses` parameter specifies a list of licenses to assign or remove.

### Example 3: Remove an assigned User's License

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$UserPrincipalName = 'SawyerM@contoso.com'
$User = Get-EntraBetaUser -ObjectId $UserPrincipalName
$SkuId = (Get-EntraBetaUserLicenseDetail -ObjectId $UserPrincipalName).SkuId
$Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses 
$Licenses.RemoveLicenses = $SkuId 
Set-EntraBetaUserLicense -ObjectId $User.ObjectId -AssignedLicenses $Licenses
```

```Output
Name                           Value
----                           -----
displayName                    SawyerM
id                             cccccccc-2222-3333-4444-dddddddddddd
jobTitle
surname                        M
mail
userPrincipalName              SawyerM@contoso.com
mobilePhone
preferredLanguage
@odata.context                 https://graph.microsoft.com/v1.0/$metadata#users/$entity
businessPhones                 {}
officeLocation
givenName                      Sawyer
```

This example demonstrates how to remove a user's license by retrieving the user details.

- `-ObjectId` parameter specifies the object Id of a user(as a UserPrincipalName or ObjectId).
- `-AssignedLicenses` parameter specifies a list of licenses to assign or remove.

## Parameters

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

### -ObjectId

Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaUser](Get-EntraBetaUser.md)
