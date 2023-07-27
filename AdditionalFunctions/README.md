# Additional Functions

The module allows to create additional functions that will be included in the module along with the regular compatibility adapter commands, giving flexibility to create helper code for customers.

In order to add a functions just add the ps1 file into this folder (AdditionalFunctions) the ps1 file and function inside must have the same name, the same prefix has to be used for this functions unless is a special case. The generation process will add the code in the file into the main psm1 file.

Unit test is present to validate that the file name and the generated function are the same, will fail if the naming in different. Additionaly new function must add pester unit testing for any command that is added.

For example `Test-CompatADScript.ps1` command as a reference of a working function

```PowerShell
function Test-CompatADScript {
    param (
        $Script
    )
    $errorFound = $false

    If($false -eq (Test-Path $Script)){
        Write-Error "Cannot find the script"
    }

    $tokens = [System.Management.Automation.PSParser]::Tokenize((Get-Content $Script), [ref]$null)
    $commands = $tokens | Where-Object -FilterScript {$_.Type -EQ 'Command'}
    foreach($cmd in $commands) {
        if($MISSING_CMDS.Contains($cmd.Content))
        {
            $errorFound = $true
            Write-Warning "Command $($cmd.Content) is not supported"
        }
    }

    if($errorFound){
        Write-Warning "Script contains commands that are not supported by the compatibility adapter."
    }
}
```

Usage

```PowerShell
Import-Module Microsoft.Graph.Compatibility.AzureAD
Test-CompatADScript ".\MyScript"
```


