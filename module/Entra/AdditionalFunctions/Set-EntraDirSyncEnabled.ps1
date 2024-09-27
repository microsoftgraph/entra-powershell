# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Set-EntraDirSyncEnabled {
    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(ParameterSetName = "All", ValueFromPipelineByPropertyName = $true, Mandatory = $true)][System.Boolean] $EnableDirsync,
        [Parameter(ParameterSetName = "All", ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId,
        [switch] $Force
    )

    PROCESS {
        $params = @{}
        $body = @{}
        $OrganizationId=''
        $params["Method"] = "PATCH"
        $URL = "https://graph.microsoft.com/v1.0/directory/onPremisesSynchronization/" + $TenantId
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($EnableDirsync -or (-not($EnableDirsync))) {
            $body["OnPremisesSyncEnabled"] =$PSBoundParameters["EnableDirsync"]
        }        
        if ([string]::IsNullOrWhiteSpace($TenantId)) {
           
            $OrganizationId = ((invoke-mggraphrequest -Method GET -Uri "https://graph.microsoft.com/v1.0/directory/onPremisesSynchronization/").value).id
           write-host($OrganizationId)
            $URL = "https://graph.microsoft.com/v1.0/directory/onPremisesSynchronization/" + $OrganizationId

            # $OnPremisesDirectorySynchronizationId = (Get-MgDirectoryOnPremiseSynchronization).Id
            # $params["OrganizationId"] = $OnPremisesDirectorySynchronizationId
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
            # $response = Update-MgOrganization @params -Headers $customHeaders
            # $response
    }
}