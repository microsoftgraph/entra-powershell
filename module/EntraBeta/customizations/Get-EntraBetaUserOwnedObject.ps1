# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADUserOwnedObject"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {
        $params = @{}

        if ($null -ne $PSBoundParameters["ObjectId"]) {
            $params["UserId"] = $PSBoundParameters["ObjectId"]
        }
        
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }

        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")
        
        $Method = "GET"
        $URI = '/beta/users/'+$params["UserId"]+'/ownedObjects'

        $response = (Invoke-GraphRequest -Uri $uri -Method $Method).value;
        
        $Top = $null
        if ($null -ne $PSBoundParameters["Top"]) {
            $Top = $PSBoundParameters["Top"]
        }

        if($Top -ne $null){
            $response | ForEach-Object {
                if ($null -ne $_ -and $Top -gt 0) {
                    $_ | ConvertTo-Json | ConvertFrom-Json
                }

                $Top = $Top - 1
            }
        }
        else {
            $response | ForEach-Object {
                if ($null -ne $_) {
                    $_ | ConvertTo-Json | ConvertFrom-Json
                }
            }
        }

    }
'@
}