# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Test-EntraBetaModulePrerequisites {   
            [CmdletBinding()]
            [OutputType([bool])]
            param (
                # The name of scope
                [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
                [Alias('Permission')]
                [string[]] $Scope
            )

            process {
                ## Initialize
                $result = $true
  
                ## Check MgModule Connection
                $EntraContext = Get-MgContext
                if ($EntraContext) {
                    if ($Scope) {
                        ## Check MgModule Consented Scopes
                        [string[]] $ScopesMissing = Compare-Object $Scope -DifferenceObject $EntraContext.Scopes | Where-Object SideIndicator -EQ '<=' | Select-Object -ExpandProperty InputObject
                        if ($ScopesMissing) {
                            $Exception = New-Object System.Security.SecurityException -ArgumentList "Additional scope(s) needed, call Connect-Entra with all of the following scopes: $($ScopesMissing -join ', ')"
                            Write-Error -Exception $Exception -Category ([System.Management.Automation.ErrorCategory]::PermissionDenied) -ErrorId 'MgScopePermissionRequired' -RecommendedAction ("Connect-Beta -Scopes $($ScopesMissing -join ',')")
                            $result = $false
                        }
                    }
                }
                else {
                    $Exception = New-Object System.Security.Authentication.AuthenticationException -ArgumentList "Authentication needed, call Connect-Entra."
                    Write-Error -Exception $Exception -Category ([System.Management.Automation.ErrorCategory]::AuthenticationError) -CategoryReason 'AuthenticationException' -ErrorId 'AuthenticationRequired'
                    $result = $false
                }

                return $result
            }
        }

        