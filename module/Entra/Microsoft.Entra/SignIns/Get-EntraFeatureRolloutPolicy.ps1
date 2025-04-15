# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Get-EntraFeatureRolloutPolicy {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id,

        [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $SearchString,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Filter,
        
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias("Select")]
        [System.String[]] $Property
    )

    PROCESS {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $baseUri = '/v1.0/policies/featureRolloutPolicies'
        $params["Method"] = "GET"
        $params["Uri"] = "$baseUri"
        $query = $null
        
        if ($null -ne $PSBoundParameters["Id"]) {
            $Id = $PSBoundParameters["Id"]
            $params["Uri"] = "/v1.0/policies/featureRolloutPolicies/$Id"
        }
        if ($null -ne $PSBoundParameters["SearchString"]) {
            $FilterValue = $PSBoundParameters["SearchString"]
            $filter = "displayName eq '$FilterValue' or startswith(displayName,'$FilterValue')"
            $f = '$' + 'Filter'
            $query += "&$f=$Filter"
        }
        if ($null -ne $PSBoundParameters["Filter"]) {
            $Filter = $PSBoundParameters["Filter"]
            $f = '$' + 'Filter'
            $query += "&$f=$Filter"
        } 
        if ($null -ne $PSBoundParameters["Property"]) {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $query += "&`$select=$($selectProperties)"
        }
        if ($null -ne $query) {
            $query = "?" + $query.TrimStart("&")
            $params["Uri"] += $query
        }
	    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $data = Invoke-GraphRequest @params -Headers $customHeaders | ConvertTo-Json | ConvertFrom-Json
        try {    
            $data = $data.value | ConvertTo-Json | ConvertFrom-Json
        }
        catch {}       

        if ($data) {
            $userList = @()
            foreach ($response in $data) {
                $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphFeatureRolloutPolicy
                $response.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $userList += $userType
            }
            $userList
        }
    }
}

