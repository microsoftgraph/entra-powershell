# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

[cmdletbinding()]
param(
    $NumberOfUsers = 10,
    $UserPrefix = 'Test123_',
    $GroupName = 'TestGroup123',
    $Domain = '<your-domain>',
    [switch] $Clean
    )

    
$GenericPassword = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$GenericPassword.Password = '<very-strong-and-complex-value>'
$GenericPassword.ForceChangePasswordNextLogin = $true

$usersArray = @()
for ($i = 0; $i -lt $NumberOfUsers; $i++) {
    $name = "$($UserPrefix)$($i)"
    $newUser = New-AzureADUser -DisplayName $Name -PasswordProfile $GenericPassword -UserPrincipalName "$name@$Domain" -AccountEnabled $true -MailNickName $name
    $usersArray += $newUser.ObjectId
    Get-AzureADUser -ObjectId $newUser.ObjectId
}

$group = New-AzureADGroup -DisplayName $GroupName -MailEnabled $false -SecurityEnabled $true -MailNickName $GroupName
Get-AzureADGroup -ObjectId $group.ObjectId

foreach ($user in $usersArray) {
    Add-AzureADGroupMember -ObjectId $($group.ObjectId) -RefObjectId $user
}

if($Clean.IsPresent){
    foreach ($user in $usersArray) {
        Remove-AzureADUser -ObjectId $user
    }    
    Remove-AzureADGroup -ObjectId $($group.ObjectId)    
}
