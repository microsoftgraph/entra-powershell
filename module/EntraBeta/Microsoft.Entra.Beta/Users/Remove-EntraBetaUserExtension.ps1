# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraBetaUserExtension {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (                
        [Parameter(ParameterSetName = "RemoveMultiple", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Collections.Generic.List`1[System.String]] $ExtensionNames,
                
        [Parameter(ParameterSetName = "RemoveSingle", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $ExtensionName,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('ObjectId')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [System.String] $UserId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $body = @{}

        if ($null -ne $PSBoundParameters["ExtensionNames"]) {
            foreach ($extName in $PSBoundParameters["ExtensionNames"]) {
                $body[$extName] = $null
            }
        }
        if ($null -ne $PSBoundParameters["ExtensionName"]) {
            $body[$PSBoundParameters["ExtensionName"]] = $null
        }

        # Invoke API call using UserId and ExtensionId
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $uri = "/beta/users/$UserId"
        $response = Invoke-MgGraphRequest -Method PATCH -Uri $uri -Body $body -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value UserId
            }
        }

        $response
    }
}

