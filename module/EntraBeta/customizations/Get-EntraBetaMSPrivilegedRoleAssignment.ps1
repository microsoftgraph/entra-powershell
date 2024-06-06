# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADMSPrivilegedRoleAssignment"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $ProviderId = $PSBoundParameters["ProviderId"]
        $ResourceId = $PSBoundParameters["ResourceId"]
        $params["Uri"] = "https://graph.microsoft.com/beta/privilegedAccess/$ProviderId/resources/$ResourceId/roleAssignments"
        $params["Method"] = "GET"
        if ($PSBoundParameters.ContainsKey("ID")) {
            $params["Uri"] = "https://graph.microsoft.com/beta/privilegedAccess/$ProviderId/resources/$ResourceId/roleAssignments/$ID"
        }
        if ($PSBoundParameters.ContainsKey("Filter")) {
            $f = '$' + 'Filter'
            $params["Uri"] = "https://graph.microsoft.com/beta/privilegedAccess/$ProviderId/resources/$ResourceId/roleAssignments?$f=$filter"
        }
        if ($PSBoundParameters.ContainsKey("top")) {
            $t = '$' + 'Top'
            $params["Uri"] = "https://graph.microsoft.com/beta/privilegedAccess/$ProviderId/resources/$ResourceId/roleAssignments?$t=$top"
        }
        if (($PSBoundParameters.ContainsKey("top")) -and ($PSBoundParameters.ContainsKey("Filter"))) {
            $f = '$' + 'Filter'
            $t = '$' + 'Top'
            $params["Uri"] = "https://graph.microsoft.com/beta/privilegedAccess/$ProviderId/resources/$ResourceId/roleAssignments?$filter=$f&$t=$top"
        }
        
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
	    if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
                
        $response = Invoke-GraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri
        try {    
            $call = $response.value 
            $call
        }
        catch {
            $response
        }
    } 
'@
}