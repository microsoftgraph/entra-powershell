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
        if ($PSBoundParameters.ContainsKey("Top")) {
            $params["Top"] = $PSBoundParameters["Top"]
            $topCount = '?$top=' + $params["Top"]
        }
        $Method = "GET"        
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $URI = "https://graph.microsoft.com/beta/reports/getAzureADApplicationSignInSummary(period='D{0}'){1}{2}" -f $Days, $filterApplied, $topCount
        $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method $Method | ConvertTo-Json | ConvertFrom-Json).value
        
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        $targetList = @()
        foreach ($res in $data) {
            $targetType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphApplicationSignInSummary
            $res.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name.Substring(0,1).ToUpper() + $_.Name.Substring(1)
                $propertyValue = $_.Value
                $targetType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $targetList += $targetType
        }
        $targetList         
    }    
'@
}