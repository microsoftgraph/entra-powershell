# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaApplicationFromApplicationTemplate {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'The ID of the application template to instantiate.')]
        [Alias('Id')]
        [ValidateNotNullOrEmpty()]
        [System.String] $ApplicationTemplateId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'The display name of the application.')]
        [ValidateNotNullOrEmpty()]
        [System.String] $DisplayName
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["ApplicationTemplateId"]) {
            $params["ApplicationTemplateId"] = $PSBoundParameters["ApplicationTemplateId"]
        }
        if ($null -ne $PSBoundParameters["DisplayName"]) {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $body = @{
            displayName = $DisplayName
        }

        $uri = "/beta/applicationTemplates/$ApplicationTemplateId/instantiate"
        $response = Invoke-GraphRequest -uri $uri -Headers $customHeaders -Body $body -Method POST | ConvertTo-Json -Depth 5 | ConvertFrom-Json
        $memberList = @()
        foreach ($data in $response) {
            $memberType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphApplicationServicePrincipal
            if (-not ($data -is [PSObject])) {
                $data = [PSCustomObject]@{ Value = $data }
            }
            $data.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name
                $propertyValue = $_.Value
                $memberType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $memberList += $memberType
        }
        $memberList
    }
}

