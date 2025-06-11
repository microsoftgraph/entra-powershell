# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaApplicationProxyConnectorGroup {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The search string to filter the connector groups.")]
        [System.String] $SearchString,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The maximum number of records to return.")]
        [Alias("Limit")]
        [System.Int32] $Top,

        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the connector group.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $Id,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Get all connector groups.")]
        [switch] $All,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter to apply to the query.")]
        [System.String] $Filter
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
        $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups"
        if ($null -ne $PSBoundParameters["SearchString"]) {
            $f = '$' + 'Filter'
            $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups?$f=name eq '$SearchString' OR startswith(name,'$SearchString')"    
        }
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$Id"
        }
        if ($null -ne $PSBoundParameters["Filter"]) {
            $f = '$' + 'Filter'
            $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups?$f=$filter"
        }        
        if ($null -ne $PSBoundParameters["All"]) {
            $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups"
        }        
        if ($PSBoundParameters.ContainsKey("Top")) {
            $t = '$' + 'Top'
            $params["Uri"] = "/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups?$t=$top"
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
}
