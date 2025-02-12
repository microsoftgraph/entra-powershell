# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Test-EntraModulePrerequisites {   
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        # The name of scope
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [Alias('Permission')]
        [string[]] $Scope
    )

    process {
        ## Allow mocking during tests
        if ($script:MockTestEntraModulePrerequisites) {
            return $true
        }

        ## Initialize
        $result = $true

        ## Check MgModule Connection
        $MgContext = Get-MgContext
        if ($MgContext) {
            if ($Scope) {
                ## Check MgModule Consented Scopes
                [string[]] $ScopesMissing = Compare-Object $Scope -DifferenceObject $MgContext.Scopes | Where-Object SideIndicator -EQ '<=' | Select-Object -ExpandProperty InputObject
                if ($ScopesMissing) {
                    $Exception = New-Object System.Security.SecurityException -ArgumentList "Additional scope(s) needed, call Connect-Entra with all of the following scopes: $($ScopesMissing -join ', ')"
                    Write-Error -Exception $Exception -Category ([System.Management.Automation.ErrorCategory]::PermissionDenied) -ErrorId 'MgScopePermissionRequired' -RecommendedAction ("Connect-Entra -Scopes $($ScopesMissing -join ',')")
                    $result = $false
                }
            }
        }
        else {
            $Exception = New-Object System.Security.Authentication.AuthenticationException -ArgumentList "Authentication needed, call Connect-Entra."
            Write-Error -Exception $Exception -Category ([System.Management.Automation.ErrorCategory]::AuthenticationError) -CategoryReason 'AuthenticationException' -ErrorId 'MgAuthenticationRequired'
            $result = $false
        }

        return $result
    }
}

