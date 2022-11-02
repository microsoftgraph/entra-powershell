# Customizing Commands

The automatic generation process can't get all the proper transformations due to the nature of the different modules, to solve this there is a mechanisim to add customization to the commands.

- Name
- Parameters
- Outputs

For each command you want to customize you need to add a new file with the command name in the `customizations` folder, the file must be a `.ps1` file with the name of the command being customized that returns an hashtable with the following structure:

```PowerShell
@{
    SourceName = "SourceCommandName" 
    TargetName = "TargetCommandNAme"
    Parameters = $null 
    Outputs = $null
}
```

Where:

- SourceName is a string with the name of the AzureAD Command to map. 
- TargetName is a string with the name of the Microsoft Graph SDK command that replaces it.
- Parameters and Outputs contains and array of hashtables, this represent the transformations required for paramters and outputs. The hashtable format is the following:

```PowerShell
@{
    SourceName = "SomeValue1"
    TargetName = "SomeValue2"
    ConversionType = SomeValue3
    SpecialMapping = SomeValue4
}
```
Where:

- SourceName is a string with the name of the command parameter in AzureAD.
- TargetName is a string with the name of the command parameter in Microsoft Graph SDK command that replaces it.
- ConversionType is a integer with the following:
  - 2 is used for name change for example from ObjectId to UserId
  - 99 is used for custom is this case it changes the name and applies a script block to the input value to transformate it.

Example 1: You know that the command Get-AzureADMSPermissionGrantPolicy in AzureAD has the equivalent Get-MgPolicyPermissionGrantPolicy in Microsoft Graph PowerShell. Assuming that you only need to make a name change the result is the following:

```PowerShell
@{
    SourceName = "Get-AzureADMSPermissionGrantPolicy"
    TargetName = "Get-MgPolicyPermissionGrantPolicy"
    Parameters = $null
    Outputs = $null
}
```

Example 2: You want to customize the command New-AzureADUser, you know that the target command in Microsoft Graph PowerShell is New-MgUser. Also you know that the parameters and outputs changes:
- For parameters the parameter PasswordProfile transform the object Microsoft.Open.AzureAD.Model.PasswordProfile to a hashtable.
- For the outputs the New-AzureADUser returns ObjectId but New-MgUser Id with the same value so we require to change the name.

```PowerShell
@{
    SourceName = "New-AzureADUser"
    TargetName = "New-MgUser"
    Parameters = @(
        @{
            SourceName = "PasswordProfile"
            TargetName = "PasswordProfile"
            ConversionType = 99
            SpecialMapping = @"
`$Value = @{
            forceChangePasswordNextSignIn = `$TmpValue.ForceChangePasswordNextLogin
            password = `$TmpValue.Password 
        }
"@
        }
    )
    Outputs =  @(
        @{
            SourceName = "Id"
            TargetName = "ObjectId"
            ConversionType = 2
            SpecialMapping = $null
        }
    )
}
```
