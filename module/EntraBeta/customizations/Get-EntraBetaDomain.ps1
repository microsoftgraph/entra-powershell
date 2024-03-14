# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADDomain"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'

    PROCESS {    
        $params = @{}
        $customHeaders = New-CustomHeaders -Module Entra -Command $MyInvocation.MyCommand
        $keysChanged = @{}
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["Name"])
        {
            $params["DomainId"] = $PSBoundParameters["Name"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Get-MgBetaDomain @params
        $response | ForEach-Object {
            if($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Name -Value Id            
                $propsToConvert = @('State')
                foreach ($prop in $propsToConvert) {
                    $value = $_.$prop | ConvertTo-Json | ConvertFrom-Json
                    $_ | Add-Member -MemberType NoteProperty -Name $prop -Value ($value) -Force
                }
            }
        }

        $response
    }    
    
'@
}