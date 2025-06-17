# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraBetaUserLicense {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the licenses to assign to the user.")]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Open.AzureAD.Model.AssignedLicenses] $AssignedLicenses,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.")]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
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
        if ($null -ne $PSBoundParameters["UserId"]) {
            $params["UserId"] = $PSBoundParameters["UserId"]
            $UserId = $PSBoundParameters["UserId"]
        }
        $jsonBody = @{
            addLicenses    = @(if ($PSBoundParameters.AssignedLicenses.AddLicenses) {
                    $PSBoundParameters.AssignedLicenses.AddLicenses | Select-Object @{Name = 'skuId'; Expression = { $_.'skuId' -replace 's', 's'.ToLower() } }
                }
                else {
                    @()
                })
            removeLicenses = @(if ($PSBoundParameters.AssignedLicenses.RemoveLicenses) {
                    $PSBoundParameters.AssignedLicenses.RemoveLicenses
                }
                else {
                    @()
                })
        } | ConvertTo-Json
        
        $customHeaders['Content-Type'] = 'application/json'

        $graphApiEndpoint = "/beta/users/$UserId/microsoft.graph.assignLicense"  
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $graphApiEndpoint -Method Post -Body $jsonBody

        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $response
    }      
}

