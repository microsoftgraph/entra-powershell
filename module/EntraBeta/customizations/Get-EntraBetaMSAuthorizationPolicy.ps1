# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSAuthorizationPolicy"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    PROCESS {    
        $params = @{}
        $customHeaders = New-CustomHeaders -Module Entra -Command $MyInvocation.MyCommand
        $keysChanged = @{}
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }

        if($PSBoundParameters.ContainsKey("Id"))
        {
            $params["AuthorizationPolicyId"] = $PSBoundParameters["Id"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Get-MgBetaPolicyAuthorizationPolicy @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                $propsToConvert = @('DefaultUserRolePermissions')
                foreach ($prop in $propsToConvert) {
                    $value = $_.$prop | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                    $_ | Add-Member -MemberType NoteProperty -Name $prop -Value ($value) -Force
                }
            }
        }
        $response
        }
'@
}