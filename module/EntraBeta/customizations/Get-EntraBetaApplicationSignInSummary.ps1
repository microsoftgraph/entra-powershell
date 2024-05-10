# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADApplicationSignInSummary"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {  
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $filterApplied = $null
        $topCount = $null
                if ($null -ne $PSBoundParameters["Days"]) {
                    $params["Days"] = $PSBoundParameters["Days"]
                }
                if ($null -ne $PSBoundParameters["Filter"]) {
                    $params["Filter"] = $PSBoundParameters["Filter"]
                    $filterApplied = '?$filter=' + $params["Filter"]
                }
                if ($null -ne $PSBoundParameters["Top"]) {
                    $params["Top"] = $PSBoundParameters["Top"]
                    $topCount = '?$top=' + $params["Top"]
                }
                $Method = "GET"
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
                    $URI = "https://graph.microsoft.com/beta/reports/getAzureADApplicationSignInSummary(period='D{0}'){1}{2}" -f $Days, $filterApplied, $topCount
                    $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method $Method | ConvertTo-Json | ConvertFrom-Json).value
                    $response
        }    
'@
}