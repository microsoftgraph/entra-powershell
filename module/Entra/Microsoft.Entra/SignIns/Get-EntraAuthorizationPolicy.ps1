# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Get-EntraAuthorizationPolicy {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id,
        
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias("Select")]
        [System.String[]] $Property
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand        
        $params["Uri"] = "/v1.0/policies/authorizationPolicy?"
        $params["Method"] = "GET"
    
        if ($null -ne $PSBoundParameters["Id"]) {
            $Id = $Id.Substring(0, 1).ToLower() + $Id.Substring(1)
            $Filter = "Id eq '$Id'"
            $f = '$' + 'Filter'
            $params["Uri"] += "&$f=$Filter"
        }
        if ($null -ne $PSBoundParameters["Property"]) {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
            $params["Uri"] += "&$properties"
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest @params -Headers $customHeaders | ConvertTo-Json | ConvertFrom-Json
        if ($response) {
            $policyList = @()
            foreach ($data in $response) {
                $policyType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphAuthorizationPolicy
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $policyType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $policyList += $policyType
            }
            $policyList 
        }
    }
}
