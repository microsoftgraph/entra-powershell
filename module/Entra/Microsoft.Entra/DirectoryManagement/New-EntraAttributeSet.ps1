# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraAttributeSet {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = "Default")]
        [Alias("Id")]
        [System.String] $AttributeSetId,

        [Parameter(ParameterSetName = "Default")]
        [System.String] $Description,
        
        [Parameter(ParameterSetName = "Default")]
        [System.Nullable`1[System.Int32]] $MaxAttributesPerSet
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes CustomSecAttributeDefinition.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $body = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params["Uri"] = "/v1.0/directory/attributeSets"
        $params["Method"] = "POST"
        
        if ($null -ne $PSBoundParameters["AttributeSetId"]) {
            $body["id"] = $PSBoundParameters["AttributeSetId"]
        }
        if ($null -ne $PSBoundParameters["Description"]) {
            $body["description"] = $PSBoundParameters["Description"]
        }
        if ($null -ne $PSBoundParameters["MaxAttributesPerSet"]) {
            $body["maxAttributesPerSet"] = $PSBoundParameters["MaxAttributesPerSet"]
        }
        $params["Body"] = $body
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Invoke-GraphRequest @params -Headers $customHeaders | ConvertTo-Json | ConvertFrom-Json
        if ($response) {
            $userList = @()
            foreach ($data in $response) {
                $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphAttributeSet
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name.Substring(0, 1).ToUpper() + $_.Name.Substring(1)
                    $propertyValue = $_.Value
                    $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $userList += $userType
            }
            $userList
        } 
    }
}# ------------------------------------------------------------------------------

