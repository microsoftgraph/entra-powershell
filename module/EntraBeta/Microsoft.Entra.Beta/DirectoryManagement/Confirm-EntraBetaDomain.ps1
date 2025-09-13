# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Confirm-EntraBetaDomain {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "The fully qualified name of the domain.")]
        [System.String] $DomainName,
        
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Allows external admin takeover of an unmanaged domain. Default is false.")]
        [System.Boolean] $ForceTakeover
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Domain.ReadWrite.Directory' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS { 
        $params = @{}
        $body = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand        
        $params["Uri"] = "/beta/domains/$DomainName/verify"
        $params["Method"] = "POST"
        
        if ($null -ne $PSBoundParameters["ForceTakeover"]) {
            $body["ForceTakeover"] = $PSBoundParameters["ForceTakeover"]
        }

        $params["Body"] = $body

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================
")  
        $response = Invoke-GraphRequest @params -Headers $customHeaders
        $response
    }
}

