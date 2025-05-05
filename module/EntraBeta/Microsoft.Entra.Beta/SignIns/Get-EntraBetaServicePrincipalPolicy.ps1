# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaServicePrincipalPolicy {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id
    )

    PROCESS {  
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["Id"] = $PSBoundParameters["Id"]
        }
        $Method = "GET"        
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $URI = "/beta/serviceprincipals/$Id/policies"
        $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method $Method | ConvertTo-Json -Depth 20 | ConvertFrom-Json).value
               
        $data = $response 
        $userList = @()
        foreach ($res in $data) {
            $userType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphServicePrincipal
            $res.PSObject.Properties | ForEach-Object {                
                $propertyName = $_.Name
                $propertyValue = $_.Value

                if ($_.Name -eq 'type') {
                    $userType | Add-Member -MemberType NoteProperty -Name 'ServicePrincipalType' -Value $propertyValue -Force

                }
                else {
                    $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
            }
            $userList += $userType
        }
        $userList 


    }    
}

