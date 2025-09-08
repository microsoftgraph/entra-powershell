# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaDirectoryObject {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
                
        [Parameter(ParameterSetName = "default", HelpMessage = "Resource types that specifies the set of resource collections, for example: user, group, and device objects. Default is directoryObject.")]
        [Alias("Types")]
        [System.Collections.Generic.List`1[System.String]] $ObjectTypes,
                
        [Parameter(ParameterSetName = "default", Mandatory = $true, HelpMessage = "One or more object IDs's, separated by commas, for which the objects are retrieved. The IDs are GUIDs, represented as strings. You can specify up to 1,000 IDs.")]
        [Alias("ObjectIds")]
        [System.Collections.Generic.List`1[System.String]] $DirectoryObjectIds,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias("Select")]
        [System.String[]] $Property
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Directory.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $body = @{}        
        $URI = '/beta/directoryObjects/microsoft.graph.getByIds?$select=*'
        if ($null -ne $PSBoundParameters["Property"]) {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
            $URI = "/beta/directoryObjects/microsoft.graph.getByIds?$properties"
        }
        if ($null -ne $PSBoundParameters["ObjectTypes"]) {
            $body["Types"] = $PSBoundParameters["ObjectTypes"]
        }
        if ($null -ne $PSBoundParameters["DirectoryObjectIds"]) {
            $body["Ids"] = $PSBoundParameters["DirectoryObjectIds"]
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Invoke-GraphRequest -Uri $URI -Method POST -Body $body -Headers $customHeaders | ConvertTo-Json -depth 10 | ConvertFrom-Json
        try {
            $response = $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        }
        catch {}
        if ($response) {
            $userList = @()
            foreach ($data in $response) {
                $userType = New-Object Microsoft.Graph.Beta.Models.MicrosoftGraphDirectoryObject
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
Set-Alias -Name Get-EntraBetaObjectByObjectId -Value Get-EntraBetaDirectoryObject -Scope Global -Force