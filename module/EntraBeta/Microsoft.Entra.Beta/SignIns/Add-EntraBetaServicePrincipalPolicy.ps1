# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Add-EntraBetaServicePrincipalPolicy {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $RefObjectId,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Policy.Read.All, Application.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {        
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        
        $rootUri = (Get-EntraEnvironment -Name (Get-EntraContext).Environment).GraphEndpoint

        if (-not $rootUri) {
            $rootUri = "https://graph.microsoft.com"
            Write-Verbose "Using default Graph endpoint: $rootUri"
        }
        if ($null -ne $PSBoundParameters["ID"]) {
            $id = $PSBoundParameters["ID"]
        }
        if ($null -ne $PSBoundParameters["RefObjectId"]) {
            $RefObjectId = $PSBoundParameters["RefObjectId"]
        }
        $uri = "/beta/serviceprincipals/$id/Policies/" + '$ref'
        $body = @{
            "@odata.id" = "$rootUri/beta/legacy/policies/$RefObjectId"
        }
        $body = $body | ConvertTo-Json
        
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-MgGraphRequest -Headers $customHeaders -Method POST -Uri $uri -Body $body -ContentType "application/json"
        $response
    }     
}

