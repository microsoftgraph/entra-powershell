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
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
                if ($null -ne $PSBoundParameters["ObjectId"]) {
                    $params["UserId"] = $PSBoundParameters["ObjectId"]
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
                
                $Method = "GET"
                $URI = '/beta/users/'+$params["UserId"]+'/ownedObjects'

                $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method $Method).value;
                
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