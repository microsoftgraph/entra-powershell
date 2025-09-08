# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraCustomSecurityAttributeDefinition {
    [CmdletBinding(DefaultParameterSetName = 'NewCustomSecurityAttributeDefinition')]
    param (
    [Parameter()]
    [System.String] $Description,
    [Parameter(Mandatory = $true)]
    [System.String] $Name,
    [Parameter(Mandatory = $true)]
    [System.String] $AttributeSet,
    [Parameter(Mandatory = $true)]
    [System.Nullable`1[System.Boolean]] $UsePreDefinedValuesOnly,
    [Parameter(Mandatory = $true)]
    [System.String] $Type,
    [Parameter(Mandatory = $true)]
    [System.Nullable`1[System.Boolean]] $IsCollection,
    [Parameter(Mandatory = $true)]
    [System.Nullable`1[System.Boolean]] $IsSearchable,
    [Parameter(Mandatory = $true)]
    [System.String] $Status
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
        $body = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $Uri = "/v1.0/directory/customSecurityAttributeDefinitions"
        $Method = "POST"

        if($null -ne $PSBoundParameters["AttributeSet"])
        {
            $body["attributeSet"] = $PSBoundParameters["AttributeSet"]
        }
        if($null -ne $PSBoundParameters["Description"])
        {
            $body["description"] = $PSBoundParameters["Description"]
        }
        if($null -ne $PSBoundParameters["IsCollection"])
        {
            $body["isCollection"] = $PSBoundParameters["IsCollection"]
        }
        if($null -ne $PSBoundParameters["IsSearchable"])
        {
            $body["isSearchable"] = $PSBoundParameters["IsSearchable"]
        }
        if($null -ne $PSBoundParameters["Name"])
        {
            $body["name"] = $PSBoundParameters["Name"]
        }
        if($null -ne $PSBoundParameters["Status"])
        {
            $body["status"] = $PSBoundParameters["Status"]
        }
        if($null -ne $PSBoundParameters["Type"])
        {
            $body["type"] = $PSBoundParameters["Type"]
        }
        if($null -ne $PSBoundParameters["UsePreDefinedValuesOnly"])
        {
            $body["usePreDefinedValuesOnly"] = $PSBoundParameters["UsePreDefinedValuesOnly"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $type= [Microsoft.Graph.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeDefinition]
        $response = Invoke-GraphRequest -Uri $Uri -Method $Method -Body $body -Headers $customHeaders | ConvertTo-Json -Depth 20 | ConvertFrom-Json
        $targetList = @()
        foreach ($item in $response) {
            $targetObject = [Activator]::CreateInstance($type)
            foreach ($property in $item.PSObject.Properties) {
                if ($targetObject.PSObject.Properties[$property.Name]) {
                    $targetObject.PSObject.Properties[$property.Name].Value = $property.Value
                }
            }
            $targetList += $targetObject
        }
        $targetList
    }
}
