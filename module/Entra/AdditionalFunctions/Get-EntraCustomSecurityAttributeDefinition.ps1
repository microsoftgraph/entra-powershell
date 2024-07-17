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
        }
        catch {}
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