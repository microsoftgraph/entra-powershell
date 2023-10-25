# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<#
.Description
Test-EntraScript looks for unsupported AzureAD commands in a script.
#>
function Test-EntraScript {
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
