# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaApplicationPolicy {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the application object (Application Object ID).")]
        [Alias("ObjectId", "ApplicationId")]
        [ValidateNotNullOrEmpty()]
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
        $URI = '/beta/applications/{0}/policies' -f $Id
        $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method $Method | ConvertTo-Json -Depth 10 | ConvertFrom-Json).value
        $response | Add-Member -MemberType AliasProperty -Value '@odata.type' -Name 'odata.type'
                
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json        
        $respList = @()
       
        foreach ($res in $data) {                      
            switch ($res.type) {
                "activityBasedTimeoutPolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGrphActivityBasedTimeoutPolicy }
                "appManagementPolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphAppManagementPolicy }
                "claimsMappingPolicies" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphClaimsMappingPolicy }
                "featureRolloutPolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphFeatureRolloutPolicy }
                "HomeRealmDiscoveryPolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphHomeRealmDiscoveryPolicy }
                "tokenIssuancePolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphTokenIssuancePolicy }
                "tokenLifetimePolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphTokenLifetimePolicy }
                "permissionGrantPolicy" { $respType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphPermissionGrantPolicy }
                default { Write-Error "Unknown type: $Type" }
            }

            $res.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name.Substring(0, 1).ToUpper() + $_.Name.Substring(1)
                $propertyValue = $_.Value
                $respType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $respList += $respType
        }
        $respList  
    }    
}

