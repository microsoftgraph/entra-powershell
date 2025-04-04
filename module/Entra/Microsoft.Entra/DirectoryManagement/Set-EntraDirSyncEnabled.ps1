# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraDirSyncEnabled {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = "default", ValueFromPipelineByPropertyName = $true, Mandatory = $true)][System.Boolean] $EnableDirsync,
        [Parameter(ParameterSetName = "default", ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId,
        [switch] $Force
    )

    PROCESS {
        $params = @{}
        $body = @{}
        $OrganizationId=''
        $params["Method"] = "PATCH"
        $URL = "https://graph.microsoft.com/v1.0/organization/" + $TenantId
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($EnableDirsync -or (-not($EnableDirsync))) {
            $body["OnPremisesSyncEnabled"] =$PSBoundParameters["EnableDirsync"]
        }        
        if ([string]::IsNullOrWhiteSpace($TenantId)) {           
            $OrganizationId = ((invoke-mggraphrequest -Method GET -Uri "https://graph.microsoft.com/v1.0/directory/onPremisesSynchronization/").value).id           
            $URL = "https://graph.microsoft.com/v1.0/organization/" + $OrganizationId
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
