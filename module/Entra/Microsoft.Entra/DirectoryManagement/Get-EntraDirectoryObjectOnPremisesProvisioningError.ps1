# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraDirectoryObjectOnPremisesProvisioningError {
    [CmdletBinding(DefaultParameterSetName = 'GetById')]
    [OutputType([System.Object])]
    param (
        [Parameter(ParameterSetName = 'GetById', HelpMessage = "The unique identifier of the tenant. Optional.")]
        [Obsolete("This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID. It should not be used for any other purpose.")]
        [System.Guid] $TenantId
    )
    
    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.Read.All, Directory.Read.All, Group.Read.All, Contacts.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    process {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters['TenantId']) {
            $params['TenantId'] = $PSBoundParameters['TenantId']
        }
        Write-Debug('============================ TRANSFORMATIONS ============================')
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $Object = @('users', 'groups', 'contacts')
        $data = @()

        try {
            foreach ($obj in $Object) {
                $uri = "/v1.0/" + $obj + "?`$filter=onPremisesProvisioningErrors/any(o:o/category ne null)&`$select=Id,UserPrincipalName,DisplayName,Mail,ProxyAddresses,onPremisesProvisioningErrors,onPremisesSyncEnabled&`$top=999"
                $response = Invoke-GraphRequest -Headers $customHeaders -Uri $uri -Method GET
                $response.value | ForEach-Object {
                    $_ | Add-Member -MemberType NoteProperty -Name ObjectType -Value $obj -Force
                    $data += $_
                }
                while ($response.ContainsKey('@odata.nextLink') -and $null -ne $response.'@odata.nextLink') {
                    $uri = $response.'@odata.nextLink'
                    $response = Invoke-GraphRequest -Uri $uri -Method GET
                    $response.value | ForEach-Object {
                        $_ | Add-Member -MemberType NoteProperty -Name ObjectType -Value $obj -Force
                        $data += $_
                    }
                }
            }
        }
        catch {
            Write-Error $_.Exception.Message
        }
    }

    end {
        if ($data.Count -eq 0) {
            Write-Output 'No data found'
        }
        else {
            $Results = New-Object -TypeName System.Collections.Generic.List[PSObject]
            foreach ($item in $data) {
                $upn = ""
                if ($item.ContainsKey('userPrincipalName')) {
                    $upn = $item.userPrincipalName
                }
                $Results.Add(
                    [PSCustomObject]@{
                        Id                    = $item.Id
                        PropertyCausingError  = $item.onPremisesProvisioningErrors.PropertyCausingError
                        UserPrincipalName     = $upn
                        Category              = $item.onPremisesProvisioningErrors.category
                        Value                 = $item.onPremisesProvisioningErrors.Value
                        OccurredDateTime      = $item.onPremisesProvisioningErrors.OccurredDateTime
                        DisplayName           = $item.displayName
                        OnPremisesSyncEnabled = $item.onPremisesSyncEnabled
                        Mail                  = $item.mail
                        ProxyAddresses        = $item.proxyAddresses
                        ObjectType            = $item.ObjectType
                    }
                )
            }
            $Results
        }
    }
}


