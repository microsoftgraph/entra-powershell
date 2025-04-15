# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraDirSyncEnabled {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = "Default", ValueFromPipelineByPropertyName = $true, Mandatory = $true)]
        [System.Boolean] $EnableDirsync,

        [Parameter(ParameterSetName = "Default", ValueFromPipelineByPropertyName = $true)]
        [Obsolete("This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID. It should not be used for any other purpose.")]
        [System.Guid] $TenantId,

        [switch] $Force
    )

    PROCESS {
        $params = @{}
        $body = @{}
        $params["Method"] = "PATCH"
        $URL = "/v1.0/organization/" + $TenantId
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($EnableDirsync -or (-not($EnableDirsync))) {
            $body["OnPremisesSyncEnabled"] = $PSBoundParameters["EnableDirsync"]
        }        
        if ([string]::IsNullOrWhiteSpace($TenantId)) {           

            $TenantId = (Get-EntraContext).TenantId            
            $URL = "/v1.0/organization/" + $TenantId
        }
        
        $params["Uri"] = $URL
        $params["Body"] = $body
        
        if ($Force) {
            $decision = 0
        }
        else {
            $title = 'Confirm'
            $question = 'Do you want to continue?'
            $Suspend = New-Object System.Management.Automation.Host.ChoiceDescription "&Suspend", "S"
            $Yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Y"
            $No = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "S"
            $choices = [System.Management.Automation.Host.ChoiceDescription[]]($Yes, $No, $Suspend)
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        }

        $response = Invoke-GraphRequest @params -Headers $customHeaders
        $response        
    }
}
