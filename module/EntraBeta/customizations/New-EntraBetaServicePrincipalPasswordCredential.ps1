# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADServicePrincipalPasswordCredential"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS{
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = 'https://graph.microsoft.com/beta/servicePrincipals'
        $Method = "POST"
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["ObjectId"] = $PSBoundParameters["ObjectId"]
            $params["StartDate"] = $PSBoundParameters["StartDate"]
            $params["EndDate"] = $PSBoundParameters["EndDate"]

            $URI = "$baseUri/$($params.ObjectId)/addPassword"
            $body = @{
                passwordCredential = @{
                    startDateTime = $PSBoundParameters["StartDate"];
                    endDateTime = $PSBoundParameters["EndDate"];
                }
            }
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method -Body $body)
        $response = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json

        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value StartDateTime
            Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value EndDateTime
            }
        }
        $response
    }
'@
}