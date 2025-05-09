# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Set-EntraBetaApplicationProxyApplicationConnectorGroup {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Publishing profile ID.")]
        [ValidateNotNullOrEmpty()]
        [Alias("ObjectId")]
        [System.String] $OnPremisesPublishingProfileId,
    
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the connector group.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ConnectorGroupId
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        $rootUri = (Get-EntraEnvironment -Name (Get-EntraContext).Environment).GraphEndpoint

        if (-not $rootUri) {
            $rootUri = "https://graph.microsoft.com"
            Write-Verbose "Using default Graph endpoint: $rootUri"
        }
        $params["Method"] = "PUT"
        $body = @{}
        if ($null -ne $PSBoundParameters["OnPremisesPublishingProfileId"]) {
            $params["Uri"] = "/beta/applications/$OnPremisesPublishingProfileId/connectorGroup/" + '$ref'
        }
        if ($null -ne $PSBoundParameters["ConnectorGroupId"]) {
            $body = @{
                "@odata.id" = "$rootUri/beta/onPremisesPublishingProfiles/applicationproxy/connectorGroups/$ConnectorGroupId"
            }
            $body = $body | ConvertTo-Json
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        Invoke-MgGraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri -Body $body -ContentType "application/json"
    }
}function Restore-EntraBetaDeletedDirectoryObject {
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id,
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [switch] $AutoReconcileProxyConflict
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Uri"] = '/beta/directory/deletedItems/'   
        $params["Method"] = "POST"    
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["Uri"] += $Id + "/microsoft.graph.restore"      
        }
        if ($PSBoundParameters.ContainsKey("AutoReconcileProxyConflict")) {
            $params["Body"] = @{
                autoReconcileProxyConflict = $true
            }
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest @params -Headers $customHeaders
        if ($response) {
            $userList = @()
            foreach ($data in $response) {
                $userType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphDirectoryObject
                $data.PSObject.Properties | ForEach-Object {
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


