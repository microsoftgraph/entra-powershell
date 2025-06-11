# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaApplicationProxyConnectorGroupMembers {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the onPremisesPublishingProfile object (OnPremisesPublishingProfile Object ID).")]
        [ValidateNotNullOrEmpty()]
        [Alias("Id")]
        [System.String] $OnPremisesPublishingProfileId,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Number of items to return.")]
        [Alias("Limit")]
        [System.Int32] $Top,

        [Parameter( ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The filter to apply.")]
        [System.String] $Filter,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Get all connector group members.")]
        [switch] $All
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Directory.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Method"] = "GET"
        $Id = $PSBoundParameters["OnPremisesPublishingProfileId"]
        $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$Id/members"
        if ($PSBoundParameters.ContainsKey("OnPremisesPublishingProfileId")) {
            $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$Id/members"
        }
        if ($PSBoundParameters.ContainsKey("Filter")) {
            $f = '$' + 'Filter'
            $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$Id/members?$f=$filter"
        }        
        if ($PSBoundParameters.ContainsKey("All")) {
            $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$Id/members"
        }        
        if ($PSBoundParameters.ContainsKey("top")) {
            $t = '$' + 'Top'
            $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$Id/members?$t=$top"
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
            $targetType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphConnector
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

