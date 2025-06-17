# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraBetaApplicationPolicy {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the policy object (Policy Object ID).")]
        [ValidateNotNullOrEmpty()]
        [System.String] $PolicyId,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the application object (Application Object ID).")]
        [ValidateNotNullOrEmpty()]
        [System.String] $Id
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {  
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["Id"]) {
            $params["Id"] = $PSBoundParameters["Id"]
        }
        if ($null -ne $PSBoundParameters["PolicyId"]) {
            $params["PolicyId"] = $PSBoundParameters["PolicyId"]
        }
        $Method = "DELETE"  
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $URI = '/beta/applications/{0}/policies/{1}/$ref' -f $Id, $PolicyId
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method $Method
        $response
    }     
}

