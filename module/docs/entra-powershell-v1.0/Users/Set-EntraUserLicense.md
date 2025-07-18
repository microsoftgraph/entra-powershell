---
author: msewaweru
description: This article provides details on the Set-EntraUserLicense command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraUserLicense
schema: 2.0.0
title: Set-EntraUserLicense
---

# Set-EntraUserLicense

## SYNOPSIS

Adds or removes licenses for a Microsoft online service to the list of assigned licenses for a user.

## SYNTAX

```powershell
Set-EntraUserLicense
 -UserId <String>
 -AssignedLicenses <AssignedLicenses>
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraUserLicense` adds or removes licenses for a Microsoft online service to the list of assigned licenses for a user.

For delegated scenarios, the calling user needs at least one of the following Microsoft Entra roles.

- Directory Writers
- License Administrator
- User Administrator

**Note**: Before assigning a license, assign a usage location to the user using:
`Set-EntraUser -ObjectId user@contoso.com -UsageLocation '<two-letter-country-code e.g. GB/US>'`.

## EXAMPLES

### Example 1: Add a license to a user based on a template user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$licensedUser = Get-EntraUser -UserId 'TemplateUser@contoso.com'
$targetUser = Get-EntraUser -UserId 'SawyerM@contoso.com'
$sourceUserLicenses = $licensedUser.AssignedLicenses
$licensesToAssign = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses 
foreach ($license in $sourceUserLicenses) {
    $assignedLicense = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
    $assignedLicense.SkuId = $license.SkuId
    $licensesToAssign.AddLicenses = $assignedLicense
    Set-EntraUserLicense -UserId $targetUser.Id -AssignedLicenses $licensesToAssign
}
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

- `-UserId` parameter specifies the object Id of a user(as a UserPrincipalName or ObjectId).
- `-AssignedLicenses` parameter specifies a list of licenses to assign or remove.

### Example 2: Add a license to a user by copying license from another user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$licensedUser = Get-EntraUser -UserId 'AdeleV@contoso.com'
$user = Get-EntraUser -UserId 'SawyerM@contoso.com' 
$license1 = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense 
$license1.SkuId = $licensedUser.AssignedLicenses.SkuId[0] 
$license2 = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
$license2.SkuId = $licensedUser.AssignedLicenses.SkuId[1]
$addLicensesArray = @()
$addLicensesArray += $license1
$addLicensesArray += $license2
$licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses 
$licenses.AddLicenses = $addLicensesArray
Set-EntraUserLicense -UserId $user.Id -AssignedLicenses $licenses
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

- `-UserId` parameter specifies the object Id of a user(as a UserPrincipalName or ObjectId).
- `-AssignedLicenses` parameter specifies a list of licenses to assign or remove.

### Example 3: Remove an assigned User's License

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$userPrincipalName = 'SawyerM@Mcontoso.com'
$user = Get-EntraUser -UserId $userPrincipalName
$skuId = (Get-EntraUserLicenseDetail -UserId $userPrincipalName).SkuId
$licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses 
$licenses.RemoveLicenses = $skuId 
Set-EntraUserLicense -UserId $user.Id -AssignedLicenses $licenses
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

- `-UserId` parameter specifies the object Id of a user(as a UserPrincipalName or ObjectId).
- `-AssignedLicenses` parameter specifies a list of licenses to assign or remove.

### Example 4: Bulk Assign Licenses to Multiple Users

```powershell
Connect-Entra -Scopes 'Organization.ReadWrite.All'
# Retrieve the SkuId for the desired license plans
$skuId1 = (Get-EntraSubscribedSku | Where-Object { $_.SkuPartNumber -eq 'AAD_PREMIUM_P2' }).SkuId
$skuId2 = (Get-EntraSubscribedSku | Where-Object { $_.SkuPartNumber -eq 'EMS' }).SkuId
# Define the user to whom the licenses will be assigned
$users = ('AljosaH@Contoso.com', 'PalameeC@Contoso.com')
# You can, alternatively, import users from a csv file. For this example, the CSV should have a column named 'user'
$users = Import-Csv -Path "C:\path\to\your\users.csv" | Select-Object -ExpandProperty user
# Create license assignment objects
$license1 = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
$license1.SkuId = $skuId1
$license2 = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
$license2.SkuId = $skuId2
$licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
$licenses.AddLicenses = $license1, $license2
# Assign the licenses to each user
foreach ($user in $users$users) {
    Set-EntraUserLicense -UserId $user -AssignedLicenses $licenses
}
```

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

### -UserId

Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId, UPN, Identity, UserPrincipalName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraUser](Get-EntraUser.md)
