# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraAttributeSet {
    [CmdletBinding(DefaultParameterSetName = 'FromParameters')]
    param (
        [Parameter(ParameterSetName = "FromParameters")]
        [Alias("Id")]
        [System.String] $AttributeSetId,
        [Parameter(ParameterSetName = "FromParameters")]
        [System.String] $Description,
        [Parameter(ParameterSetName = "FromParameters")]
        [System.Nullable`1[System.Int32]] $MaxAttributesPerSet
    )

    PROCESS {    
        $params = @{}
        $body = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params["Uri"] = "https://graph.microsoft.com/v1.0/directory/attributeSets"
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

