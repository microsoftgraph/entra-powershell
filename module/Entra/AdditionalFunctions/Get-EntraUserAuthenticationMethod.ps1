# ---------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ---------------------------------------------------------------------------
function Get-EntraUserAuthenticationMethod {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Enter the User ID (ObjectId or UserPrincipalName) of the user whose authentication requirements you want to update.")]
        [Alias("ObjectId")]
        [System.String] $UserId
    )

    PROCESS {
        try {
            # Initialize headers and URI
            $params = @{ }
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

            if ($null -ne $PSBoundParameters["UserId"]) {
                $params["UserId"] = $PSBoundParameters["UserId"]
            }

            $params["Url"] = "https://graph.microsoft.com/v1.0/users/$($params.UserId)/authentication/methods"

            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")

            # Make the API call
            $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params.Url -Method GET

            if ($response.ContainsKey('value')) {
                $response = $response.value
            }
    
            $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json       
            
            $authMethodList = @()
            foreach ($res in $data) {
                $authMethodType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphAuthenticationMethod
                $res.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name.Substring(0, 1).ToUpper() + $_.Name.Substring(1)
                    $propertyValue = $_.Value
                    $authMethodType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $authMethodType | Add-Member -MemberType AliasProperty -Name AuthenticationMethodType -Value '@odata.type'
                $authMethodList += $authMethodType
            }

            # Check if Format-List is used and select properties accordingly
            if ($PSCmdlet.MyInvocation.BoundParameters['Format'] -eq 'List') {
                # Return all properties
                $authMethodList
            }
            else {
                # Return default properties
                $authMethodList | Select-Object -Property Id, DisplayName, AuthenticationMethodType | Format-Table -AutoSize
            }
        }
        catch {
            Write-Error "An error occurred while retrieving user authentication methods: $_"
        }
    }
}
