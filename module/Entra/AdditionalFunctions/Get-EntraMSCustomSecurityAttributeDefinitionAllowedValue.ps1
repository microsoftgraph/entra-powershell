function Get-EntraMSCustomSecurityAttributeDefinitionAllowedValue {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id,
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Filter,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $CustomSecurityAttributeDefinitionId
    )

    PROCESS {    
        $params = @{}
        $params["Uri"] = "https://graph.microsoft.com/beta/directory/customSecurityAttributeDefinitions/$CustomSecurityAttributeDefinitionId/allowedValues/"
        $params["Method"] = "GET"
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

        if ($null -ne $PSBoundParameters["Id"]) {
            $params["Uri"] += $Id
        }
        if ($null -ne $PSBoundParameters["Filter"]) {
            $params["Uri"] += '?$filter=' + $Filter
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = (Invoke-GraphRequest @params -Headers $customHeaders) | ConvertTo-Json -Depth 5 | ConvertFrom-Json 
        try {
            $response = $response.value
            $response | Select-Object id, isActive
        }
        catch {
            $response | Select-Object id, isActive, '@odata.context'
        }
    }
}