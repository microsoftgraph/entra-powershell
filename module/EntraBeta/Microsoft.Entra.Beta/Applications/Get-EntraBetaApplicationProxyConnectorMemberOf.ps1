# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaApplicationProxyConnectorMemberOf {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the application proxy connector.")]
        [ValidateNotNullOrEmpty()]
        [Alias("Id")]
        [System.String] $OnPremisesPublishingProfileId
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Method"] = "GET"
        $Id = $PSBoundParameters["OnPremisesPublishingProfileId"]
        $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectors/$Id/memberOf"
        if ($PSBoundParameters.ContainsKey("OnPremisesPublishingProfileId")) {
            $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectors/$Id/memberOf"
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $response = Invoke-GraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri 
        try {    
            $data = $response.Value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        }
        catch {
            $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        }
        
        $targetList = @()
        foreach ($res in $data) {
            $targetType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphConnectorGroup
            $res.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name.Substring(0, 1).ToUpper() + $_.Name.Substring(1)
                $propertyValue = $_.Value
                $targetType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $targetList += $targetType
        }
        $targetList    

    }        
}# ------------------------------------------------------------------------------

