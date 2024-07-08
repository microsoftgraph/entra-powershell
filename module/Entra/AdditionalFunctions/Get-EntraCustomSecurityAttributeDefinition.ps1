function Get-EntraCustomSecurityAttributeDefinition {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $Id
    )

    PROCESS {    
        $params = @{}
        $Method = "GET"
        $Uri = "https://graph.microsoft.com/v1.0/directory/customSecurityAttributeDefinitions/"
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
            $response
        }
        catch {
            $response
        }
        
    }
}