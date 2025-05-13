# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaServicePrincipalKeyCredential {
    function Get-EntraBetaServicePrincipalKeyCredential {
        [CmdletBinding(DefaultParameterSetName = 'Default')]
        param (
            [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
            [Alias("ObjectId")]
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

            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
            $response = (Get-MgBetaServicePrincipal -Headers $customHeaders -ServicePrincipalId $PSBoundParameters["ServicePrincipalId"]).KeyCredentials
            $response | ForEach-Object {
                if ($null -ne $_) {
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name StartDate -Value StartDateTime
                    Add-Member -InputObject $_ -MemberType AliasProperty -Name EndDate -Value EndDateTime
                }
            }
            $response
        }
    }    
}

