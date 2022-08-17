# Customizing Cmdlets

The automatic generation process can't get all the proper transformations due to the nature of the different modules, to solve this wee add a nechanisim to add customization to the cmdlets, there is three posible customizations:

- Name
- Parameters
- Outputs

The class `CmdletMapper` has the method for this:

```Powershell
AddCustomization([string] $Name, [string] $TargetName, [hashtable] $Parameters, [hashtable] $Outputs)
```

Lets see some examples, asumming we have a general mapper object:

```Powershell
$mapper = [CmdletMapper]::new()
```

## Customize Cmdlet Name

Lets use `Remove-AzureADMSPermissionGrantPolicy` as we can see the *noun* here is `PermissionGrantPolicy` there is no such *noun* in Microsoft Graph PowerShell SDK, but we know there is an equivalent cmdlet this is `Remove-MgPolicyPermissionGrantPolicy`, for this one we are only adding the referent to the name, this means puting the actual AzureAD cmdlet as `Name` and the Microsoft Graph cmdlet as `TargetName`, the code is the following:

```Powershell
$mapper.AddCustomization("Remove-AzureADMSPermissionGrantPolicy","Remove-MgPolicyPermissionGrantPolicy", $null, $null)
```

## Customize Cmdlet Paramaters and Outputs

To Add Parameters or Outputs we need to create a `DataMap` for each one of them and add those to the respective hashtable. For this type of customizations there is two options:

- Name customization using `[DataMap]::New("OriginalName","NewName", 2, $null)`
- Complex customization using `[DataMap]::New("OriginalName","NewName", 99, $transformationScript)`

For this ones lets use `New-AzureADUser` cmdlet as example, as this has a complex parameter transformation and a simple output name change.

For name changes if we want ot change `Id` for `ObjectId` then use the following:

`[DataMap]::New("Id","ObjectId", 2, $null)`

Complex change we need a scriptBlock that with two restrictions it will assume that the input value comes in the variable ``$TmpValue` and has to return the tranformed value in a different variable called `$Value`. 

For example `New-AzureADUser` has a parameter `PasswordProfile` with type `Microsoft.Open.AzureAD.Model.PasswordProfile` and `New-MgUser` has the same parameter but with type `IMicrosoftGraphPasswordProfile` the scriptblock that transform one to the other is the following:


```Powershell
$script = @"
`$Value = @{
    forceChangePasswordNextSignIn = `$TmpValue.ForceChangePasswordNextLogin
    password = `$TmpValue.Password 
}
"@
```

If we take both exaples we can see that the final code for customizing `New-AzureADUser` is:

```Powershell
$mapper = [CmdletMapper]::new()
$param = @{}
$outputs = @{}
$script = @"
`$Value = @{
    forceChangePasswordNextSignIn = `$TmpValue.ForceChangePasswordNextLogin
    password = `$TmpValue.Password 
}
"@
$param.Add("PasswordProfile", [DataMap]::New("PasswordProfile", "PasswordProfile", 99, [Scriptblock]::Create($script)))
$outputs.Add("Id",[DataMap]::New("Id","ObjectId", 2, $null))
$mapper.AddCustomization("New-AzureADUser","New-MgUser", $param, $outputs)
```

