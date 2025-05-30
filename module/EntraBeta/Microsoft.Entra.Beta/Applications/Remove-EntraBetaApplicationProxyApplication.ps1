# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraBetaApplicationProxyApplication {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Alias("ObjectId")]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the application object (Application Object ID).")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ApplicationId,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Remove the application from Azure Active Directory.")]
        [System.Nullable`1[System.Boolean]] $RemoveADApplication
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
        if ($null -ne $PSBoundParameters["ApplicationId"]) {
            $ApplicationId = $PSBoundParameters["ApplicationId"]
        }
        if ($null -ne $PSBoundParameters["RemoveADApplication"] -and $true -eq $PSBoundParameters["RemoveADApplication"] ) {
            $body = @{ 
                onPremisesPublishing = @{ 
                    internalUrl = "PowerShellDeleteApplication" 
                    externalUrl = "PowerShellDeleteApplication" 
                } 
            } | ConvertTo-Json
            Invoke-GraphRequest -Uri "/beta/applications/$ApplicationId" -Method PATCH -Body $body
            Invoke-GraphRequest -Uri "/beta/applications/$ApplicationId" -Method DELETE -Headers $customHeaders
        }
        if ($null -eq $PSBoundParameters["RemoveADApplication"] -or ($null -ne $PSBoundParameters["RemoveADApplication"] -and $false -eq $PSBoundParameters["RemoveADApplication"])) {
            $body = @{ 
                onPremisesPublishing = @{ 
                    internalUrl = "PowerShellDeleteApplication" 
                    externalUrl = "PowerShellDeleteApplication" 
                } 
            } | ConvertTo-Json
            Invoke-GraphRequest -Uri "/beta/applications/$ApplicationId" -Method PATCH -Headers $customHeaders -Body $body
        }
        
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    }    
}

