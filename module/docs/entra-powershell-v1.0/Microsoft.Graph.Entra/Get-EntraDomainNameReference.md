---
title: Get-EntraDomainNameReference
description: This article provides details on the Get-EntraDomainNameReference command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDomainNameReference

## SYNOPSIS
This cmdlet retrieves the objects that are referenced with a given domain name.

## SYNTAX

```powershell
Get-EntraDomainNameReference 
    -Name <String> 
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves the objects that are referenced with a given domain name.

## EXAMPLES

### Example 1: Retrieve the domain name reference objects for a domain
```powershell
PS C:\> Get-EntraDomainNameReference -Name M365x99297270.onmicrosoft.com
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {}
preferredLanguage               :
mail                            : Hood@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-2465307174-1183218137-1495780736-693310342
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=Hood@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {}
department                      :
jobTitle                        :
proxyAddresses                  : {SMTP:Hood@M365x99297270.OnMicrosoft.com}
legalAgeGroupClassification     :
assignedPlans                   : {}
id                              : 92f19a26-79d9-4686-80cd-275986135329
showInAddressList               :
@odata.type                     : #microsoft.graph.user
officeLocation                  :
postalCode                      :
serviceProvisioningErrors       : {}
userPrincipalName               : Hood@M365x99297270.OnMicrosoft.com
isResourceAccount               :
externalUserStateChangeDateTime :
onPremisesExtensionAttributes   : @{extensionAttribute2=; extensionAttribute1=; extensionAttribute12=; extensionAttribute13=; extensionAttribute10=; extensionAttribute11=; extensionAttribute15=;
                                  extensionAttribute14=; extensionAttribute9=; extensionAttribute8=; extensionAttribute7=; extensionAttribute6=; extensionAttribute5=; extensionAttribute4=;
                                  extensionAttribute3=}
provisionedPlans                : {}
state                           :
onPremisesImmutableId           :
passwordProfile                 :
deletedDateTime                 :
businessPhones                  : {}
accountEnabled                  : True
onPremisesSyncEnabled           :
employeeType                    :
onPremisesProvisioningErrors    : {}
preferredDataLocation           :
displayName                     : Conf Room Hood
country                         :
otherMails                      : {}
refreshTokensValidFromDateTime  : 7/12/2023 2:36:41 AM
mailNickname                    : Hood
userType                        : Member
employeeHireDate                :
createdDateTime                 : 7/8/2023 12:21:28 AM
city                            :
companyName                     :
signInSessionsValidFromDateTime : 7/12/2023 2:36:41 AM
employeeOrgData                 :
mobilePhone                     :
externalUserState               :
onPremisesSecurityIdentifier    :
givenName                       :
streetAddress                   :
onPremisesSamAccountName        :
employeeId                      :
employeeLeaveDateTime           :
passwordPolicies                :
authorizationInfo               : @{certificateUserIds=System.Object[]}
usageLocation                   :
faxNumber                       :
surname                         :
onPremisesDistinguishedName     :
onPremisesDomainName            :
isLicenseReconciliationNeeded   : True
ObjectId                        : 92f19a26-79d9-4686-80cd-275986135329
DeletionTimestamp               :
DirSyncEnabled                  :
ImmutableId                     :
Mobile                          :
ProvisioningErrors              : {}
TelephoneNumber                 : {}
UserState                       :
UserStateChangedOn              :

ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {}
preferredLanguage               :
mail                            : Rainier@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-439148996-1144104365-1016364943-1439988639
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=Rainier@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
assignedLicenses                : {}
department                      :
jobTitle                        :
proxyAddresses                  : {SMTP:Rainier@M365x99297270.OnMicrosoft.com}
legalAgeGroupClassification     :
assignedPlans                   : {}
id                              : 1a2ce1c4-a5ad-4431-8f7f-943c9f7bd455
showInAddressList               :
@odata.type                     : #microsoft.graph.user
officeLocation                  :
postalCode                      :
serviceProvisioningErrors       : {}
userPrincipalName               : Rainier@M365x99297270.OnMicrosoft.com
isResourceAccount               :
externalUserStateChangeDateTime :
onPremisesExtensionAttributes   : @{extensionAttribute2=; extensionAttribute1=; extensionAttribute12=; extensionAttribute13=; extensionAttribute10=; extensionAttribute11=; extensionAttribute15=;
                                  extensionAttribute14=; extensionAttribute9=; extensionAttribute8=; extensionAttribute7=; extensionAttribute6=; extensionAttribute5=; extensionAttribute4=;
                                  extensionAttribute3=}
provisionedPlans                : {}
state                           :
onPremisesImmutableId           :
passwordProfile                 :
deletedDateTime                 :
businessPhones                  : {}
accountEnabled                  : True
onPremisesSyncEnabled           :
employeeType                    :
onPremisesProvisioningErrors    : {}
preferredDataLocation           :
displayName                     : Conf Room Rainier
country                         :
otherMails                      : {}
refreshTokensValidFromDateTime  : 10/12/2023 4:05:47 AM
mailNickname                    : Rainier
userType                        : Member
employeeHireDate                :
createdDateTime                 : 7/8/2023 12:21:29 AM
city                            :
companyName                     :
signInSessionsValidFromDateTime : 10/12/2023 4:05:47 AM
employeeOrgData                 :
mobilePhone                     :
externalUserState               :
onPremisesSecurityIdentifier    :
givenName                       :
streetAddress                   :
onPremisesSamAccountName        :
employeeId                      :
employeeLeaveDateTime           :
passwordPolicies                :
authorizationInfo               : @{certificateUserIds=System.Object[]}
usageLocation                   :
faxNumber                       :
surname                         :
onPremisesDistinguishedName     :
onPremisesDomainName            :
isLicenseReconciliationNeeded   : True
ObjectId                        : 1a2ce1c4-a5ad-4431-8f7f-943c9f7bd455
DeletionTimestamp               :
DirSyncEnabled                  :
ImmutableId                     :
Mobile                          :
ProvisioningErrors              : {}
TelephoneNumber                 : {}
UserState                       :
UserStateChangedOn              :
```

This example shows how to retrieve the domain name reference objects for a domain that is specified through the -Name parameter.

## PARAMETERS

### -Name
The name of the domain name for which the referenced objects are retrieved.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
