# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Add-EntraBetaApplicationPolicy {
    [CmdletBinding(DefaultParameterSetName = 'ByApplicationIdAndPolicyId')]
    param (     
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Policy ID of the policy to be added to the application.")]
        [Alias('PolicyId')]
        [ValidateNotNullOrEmpty()]
        [System.String] $RefObjectId,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the application object (Application Object ID).")]
        [Alias('ObjectId', 'ApplicationId')]
        [ValidateNotNullOrEmpty()]
        [System.String] $Id
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All, Policy.ReadWrite.ApplicationConfiguration' to authenticate."
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
        $uri = "/beta/applications/$id/Policies/" + '$ref'
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

