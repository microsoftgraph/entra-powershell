# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraCustomSecurityAttributeDefinition {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes CustomSecAttributeDefinition.Read.All, CustomSecAttributeDefinition.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $Method = "GET"
        $Uri = "/v1.0/directory/customSecurityAttributeDefinitions/"
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        
        if ($null -ne $PSBoundParameters["Id"]) {
            $Uri += $Id
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = (Invoke-GraphRequest -Uri $Uri -Method $Method -Headers $customHeaders) | ConvertTo-Json | ConvertFrom-Json
        try {    
            $response = $response.value 
        }
        catch {}
        if($response){
            $userList = @()
            foreach ($data in $response) {
                $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeDefinition
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $userList += $userType
            }
            $userList
        }        
    }
}

