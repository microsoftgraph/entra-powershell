# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Add-EntraBetaApplicationPolicy {
    [CmdletBinding(DefaultParameterSetName = 'ByApplicationIdAndPolicyId')]
    param (
                
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $RefObjectId,
                
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id
    )

    PROCESS {        
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        
        $environment = (Get-EntraContext).Environment
        $rootUri = (Get-EntraEnvironment -Name $environment).GraphEndpoint
        if ($null -ne $PSBoundParameters["ID"]) {
            $id = $PSBoundParameters["ID"]
        }
        if ($null -ne $PSBoundParameters["RefObjectId"]) {
            $RefObjectId = $PSBoundParameters["RefObjectId"]
        }
        $uri = "/beta/applications/$id/Policies/" + '$ref'
        $body = @{
            "@odata.id" = "$rootUri/beta/legacy/policies/$RefObjectId"
        }
        $body = $body | ConvertTo-Json
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-MgGraphRequest -Headers $customHeaders -Method POST -Uri $uri -Body $body -ContentType "application/json"
        $response
    }     
}

