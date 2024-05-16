# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADUserLicense"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{ObjectId = "Id"}
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["UserId"] = $PSBoundParameters["ObjectId"]
            $UserId = $PSBoundParameters["ObjectId"]
        }
        $jsonBody = @{
            addLicenses    = @(if ($PSBoundParameters.AssignedLicenses.AddLicenses) {
                                $PSBoundParameters.AssignedLicenses.AddLicenses | Select-Object @{Name='skuId'; Expression={$_.'skuId' -replace 's', 's'.ToLower()}}
                              } else {
                                @()
                              })
            removeLicenses = @(if ($PSBoundParameters.AssignedLicenses.RemoveLicenses) {
                                   $PSBoundParameters.AssignedLicenses.RemoveLicenses
                               } else {
                                   @()
                               })
        } | ConvertTo-Json
        
        $customHeaders['Content-Type'] = 'application/json'

        $graphApiEndpoint = "https://graph.microsoft.com/beta/users/$UserId/microsoft.graph.assignLicense"

        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $graphApiEndpoint -Method Post -Body $jsonBody

        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $response
        }  
'@
}