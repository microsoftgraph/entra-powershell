# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADApplicationProxyApplication"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{ObjectId = "Id"}
    
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $ObjectId = $PSBoundParameters["ObjectId"]
        }
        if($null -ne $PSBoundParameters["RemoveADApplication"] -and $true -eq $PSBoundParameters["RemoveADApplication"] )
        {
            $body = @{ 
                onPremisesPublishing = @{ 
                    internalUrl = "PowerShellDeleteApplication" 
                    externalUrl = "PowerShellDeleteApplication" 
               } 
            } | ConvertTo-Json
            Invoke-GraphRequest -Uri "https://graph.microsoft.com/beta/applications/$ObjectId" -Method PATCH -Body $body
            Invoke-GraphRequest -Uri "https://graph.microsoft.com/beta/applications/$ObjectId" -Method DELETE -Headers $customHeaders
        }
        if($null -eq $PSBoundParameters["RemoveADApplication"] -or ($null -ne $PSBoundParameters["RemoveADApplication"] -and $false -eq $PSBoundParameters["RemoveADApplication"]))
        {
            $body = @{ 
                onPremisesPublishing = @{ 
                    internalUrl = "PowerShellDeleteApplication" 
                    externalUrl = "PowerShellDeleteApplication" 
               } 
            } | ConvertTo-Json
            Invoke-GraphRequest -Uri "https://graph.microsoft.com/beta/applications/$ObjectId" -Method PATCH -Headers $customHeaders -Body $body
        }
        
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        }
'@
}