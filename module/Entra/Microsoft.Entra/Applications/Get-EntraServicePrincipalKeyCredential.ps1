# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraServicePrincipalKeyCredential {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Alias("ObjectId")]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the service principal object (Service Principal Object ID).")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ServicePrincipalId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    process {

        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $response = (Get-MgServicePrincipal -Headers $customHeaders -ServicePrincipalId $PSBoundParameters["ServicePrincipalId"]).KeyCredentials
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value StartDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value EndDateTime
            }
        }
        $response

    }
}

