# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Get-EntraBetaUser {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Maximum number of results to return.")]
        [Alias("Limit")]
        [ValidateRange(1, [int]::MaxValue)]
        [System.Nullable`1[System.Int32]] $Top,

        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.")]
        [System.String] $UserId,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter to apply to the query.")]
        [System.String] $Filter,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Return all users.")]
        [switch] $All,

        [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Search for users using a search string from different properties e.g. DisplayName, Job Title, UPN etc.")]
        [System.String] $SearchString,
        
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Alias("Select")]
        [System.String[]] $Property,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "This controls how many items are fetched per query, not the total number of items returned.")]
        [ValidateRange(1, 999)]
        [System.Nullable`1[System.Int32]] $PageSize,

        [Parameter(ParameterSetName = "GetFiltered", ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Specifies the filter for enabled or disabled users. Valid values are EnabledOnly and DisabledOnly.")]
        [ValidateSet("EnabledOnly", "DisabledOnly")]
        [System.String] $EnabledFilter,

        [Parameter(ParameterSetName = "GetFiltered", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Returns only users that have validation errors.")]
        [Switch] $HasErrorsOnly,

        [Parameter(ParameterSetName = "GetFiltered", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Filter for only users that require license reconciliation.")]
        [Switch] $LicenseReconciliationNeededOnly,

        [Parameter(ParameterSetName = "GetFiltered", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Returns only users who are synchronized through Azure Active Directory Sync.")]
        [Switch] $Synchronized,

        [Parameter(ParameterSetName = "GetFiltered", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Returns only users who are not assigned a license.")]
        [Switch] $UnlicensedUsersOnly
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $topCount = $null
        $pageSizeCount = $null
        $upnPresent = $false
        $baseUri = '/beta/users'
        $properties = '$select=Id,AccountEnabled,AgeGroup,OfficeLocation,AssignedLicenses,AssignedPlans,City,CompanyName,ConsentProvidedForMinor,Country,CreationType,Department,DisplayName,GivenName,OnPremisesImmutableId,JobTitle,LegalAgeGroupClassification,Mail,MailNickName,MobilePhone,OnPremisesSecurityIdentifier,OtherMails,PasswordPolicies,PasswordProfile,PostalCode,PreferredLanguage,ProvisionedPlans,OnPremisesProvisioningErrors,ProxyAddresses,RefreshTokensValidFromDateTime,ShowInAddressList,State,StreetAddress,Surname,BusinessPhones,UsageLocation,UserPrincipalName,ExternalUserState,ExternalUserStateChangeDateTime,UserType,OnPremisesLastSyncDateTime,ImAddresses,SecurityIdentifier,OnPremisesUserPrincipalName,ServiceProvisioningErrors,IsResourceAccount,OnPremisesExtensionAttributes,DeletedDateTime,OnPremisesSyncEnabled,EmployeeType,EmployeeHireDate,CreatedDateTime,EmployeeOrgData,preferredDataLocation,Identities,onPremisesSamAccountName,EmployeeId,EmployeeLeaveDateTime,AuthorizationInfo,FaxNumber,OnPremisesDistinguishedName,OnPremisesDomainName,signInSessionsValidFromDateTime,onPremisesSyncEnabled,licenseAssignmentStates'
        $params["Method"] = "GET"
        $params["Uri"] = "$baseUri"
        $query = $null

        if ($PSBoundParameters.ContainsKey("PageSize")) {
            $pageSizeCount = $PSBoundParameters["PageSize"]
        } 
        
        if ($null -ne $PSBoundParameters["Property"]) {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
            $query = "$properties"
        }

        if ($PSBoundParameters.ContainsKey("Top")) {
            $topCount = $PSBoundParameters["Top"]
            if ($null -ne $pageSizeCount -and $topCount -gt $pageSizeCount) {
                $params["Uri"] += "&`$top=$pageSizeCount"
            }
            elseif ($topCount -gt 999 -or ($null -ne $pageSizeCount -and $pageSizeCount -gt 999)) {
                $query += "&`$top=999"
            }
            else {
                $query += "&`$top=$topCount"
            }
        }
        elseif ($null -ne $pageSizeCount) {
            if ($pageSizeCount -gt 999) {
                $params["Uri"] += "&`$top=999"
            }
            else {
                $params["Uri"] += "&`$top=$pageSizeCount"
            }
        }
        
        if ($null -ne $PSBoundParameters["SearchString"]) {
            $TmpValue = $PSBoundParameters["SearchString"]
            $SearchString = "`$search=`"userprincipalname:$TmpValue`" OR `"state:$TmpValue`" OR `"mailNickName:$TmpValue`" OR `"mail:$TmpValue`" OR `"jobTitle:$TmpValue`" OR `"displayName:$TmpValue`" OR `"department:$TmpValue`" OR `"country:$TmpValue`" OR `"city:$TmpValue`""
            $query += "&$SearchString"
            $customHeaders['ConsistencyLevel'] = 'eventual'
        }
        if ($null -ne $PSBoundParameters["UserId"]) {
            $UserId = $PSBoundParameters["UserId"]
            if ($UserId -match '^[#a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$') {
                $UserId = [uri]::EscapeDataString($UserId)
                $f = '$' + 'Filter'
                $Filter = "UserPrincipalName eq '$UserId'"
                $params["Uri"] += "&$f=$Filter"
                $upnPresent = $true
            }
            else {
                $params["Uri"] = "$baseUri/$($UserId)?$properties"
            }
        }

        $filterParameters = @()

        if ($null -ne $PSBoundParameters["Filter"]) {
            $Filter = $PSBoundParameters["Filter"]
            $filterParameters += $Filter
        }
        
        # if -Enabled switch is selected, add to filter
        if ($null -ne $PSBoundParameters["EnabledFilter"]) {
            if ($PSBoundParameters["EnabledFilter"] -eq "DisabledOnly") {
                $stateFilter = "accountEnabled eq false"
            }
            else {
                $stateFilter = "accountEnabled eq true"
            }
            $filterParameters += $stateFilter
        }

        # if Synchronized switch is selected, add to filter
        if ($null -ne $PSBoundParameters["Synchronized"]) {
            $synchronizedFilter = "onPremisesSyncEnabled eq true"
            $filterParameters += $synchronizedFilter
        }

        # If any filters were added, combine them and add to the URI
        if ($filterParameters.Count -gt 0) {
            $combinedFilter = $filterParameters -join ' and '
            $f = '$' + 'Filter'
            $query += "&$f=$combinedFilter"
        }

        if ($null -ne $query) {
            $query = "?" + $query.TrimStart("&")
            $params["Uri"] += $query
        }
	    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest @params -Headers $customHeaders
        if ($upnPresent -and ($null -eq $response.value -or $response.value.Count -eq 0)) {
            Write-Error "Resource '$UserId' does not exist or one of its queried reference-property objects are not present.

Status: 404 (NotFound)
ErrorCode: Request_ResourceNotFound"
        }
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        try {
            $data = $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $all = $All.IsPresent
            $increment = $topCount - $data.Count
            while (($response.'@odata.nextLink' -and (($all -and ($increment -lt 0)) -or $increment -gt 0))) {
                $params["Uri"] = $response.'@odata.nextLink'
                if ($increment -gt 0) {
                    $pageValue = 999
                    if ($null -ne $pageSizeCount) {
                        $pageValue = $pageSizeCount
                    }

                    $minValue = [Math]::Min($increment, $pageValue)
                    $params["Uri"] = $params["Uri"].Replace('$top=999', "`$top=$minValue")
                    $increment -= $minValue
                }
                $response = Invoke-GraphRequest @params 
                $data += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            }
        }
        catch {}        
        $data | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name UserState -Value ExternalUserState
                Add-Member -InputObject $_ -MemberType AliasProperty -Name UserStateChangedOn -Value ExternalUserStateChangeDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name Mobile -Value mobilePhone
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimestamp -Value DeletedDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DirSyncEnabled -Value OnPremisesSyncEnabled
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ImmutableId -Value onPremisesImmutableId
                Add-Member -InputObject $_ -MemberType AliasProperty -Name LastDirSyncTime -Value OnPremisesLastSyncDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ProvisioningErrors -Value onPremisesProvisioningErrors
                Add-Member -InputObject $_ -MemberType AliasProperty -Name TelephoneNumber -Value BusinessPhones
            }
        }

        $userList = @()
        foreach ($response in $data) {
            # Filter users with service provisioning errors if HasErrorsOnly switch is specified
            if ($PSBoundParameters.ContainsKey("HasErrorsOnly")) {
                if ($null -eq $response.ServiceProvisioningErrors -or $response.ServiceProvisioningErrors.Count -eq 0) {
                    continue
                }
            }

            # Filter users with service provisioning errors if LicenseReconciliationNeededOnly switch is specified
            if ($PSBoundParameters.ContainsKey("LicenseReconciliationNeededOnly")) {
                if ($null -eq $response.licenseAssignmentStates -or $response.licenseAssignmentStates.Count -eq 0) {
                    continue
                }

                $hasLicenseError = $false
                # REF: https://learn.microsoft.com/en-us/graph/api/resources/licenseassignmentstate?view=graph-rest-1.0
                foreach ($licenseAssignment in $response.licenseAssignmentStates) {
                    if ($licenseAssignment.error -neq $null -and $licenseAssignment.error -ne 'None') {
                        $hasLicenseError = $true
                        break
                    }
                }
                
                if (-not $hasLicenseError) {
                    continue
                }
            }

            # Filter unlicensed users if UnlicensedUsersOnly switch is specified.
            if ($null -ne $PSBoundParameters["UnlicensedUsersOnly"]) {
                if ($response.AssignedLicenses.Count -gt 0) {
                    continue
                }
            }

            $userType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphUser
            $response.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name
                $propertyValue = $_.Value
                $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $userList += $userType
        }
        $userList 
    }    
}

