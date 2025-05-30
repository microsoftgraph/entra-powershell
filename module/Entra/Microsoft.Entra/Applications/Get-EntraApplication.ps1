# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraApplication {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The maximum number of records to return.")]
        [Alias("Limit")]
        [System.Nullable`1[System.Int32]] $Top,

        [Alias('ObjectId')]
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the application object (Application Object ID).")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ApplicationId,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Get all applications.")]
        [switch] $All,

        [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Search for applications by name.")]
        [System.String] $SearchString,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter to apply to the query.")]
        [System.String] $Filter,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Alias("Select")]
        [System.String[]] $Property
    )

    PROCESS {  
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{SearchString = "Filter"; ApplicationId = "Id" }
        if ($null -ne $PSBoundParameters["SearchString"]) {
            $TmpValue = $PSBoundParameters["SearchString"]
            $Value = "displayName eq '$TmpValue' or startswith(displayName,'$TmpValue')"
            $params["Filter"] = $Value
        }
        if ($null -ne $PSBoundParameters["ApplicationId"]) {
            $params["ApplicationId"] = $PSBoundParameters["ApplicationId"]
        }
        if ($null -ne $PSBoundParameters["Property"]) {
            $params["Property"] = $PSBoundParameters["Property"]
        }
        if ($null -ne $PSBoundParameters["Filter"]) {
            $TmpValue = $PSBoundParameters["Filter"]
            foreach ($i in $keysChanged.GetEnumerator()) {
                $TmpValue = $TmpValue.Replace($i.Key, $i.Value)
            }
            $Value = $TmpValue
            $params["Filter"] = $Value
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["All"]) {
            if ($PSBoundParameters["All"]) {
                $params["All"] = $PSBoundParameters["All"]
            }
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($PSBoundParameters.ContainsKey("Top")) {
            $params["Top"] = $PSBoundParameters["Top"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Get-MgApplication @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
                Add-Member -InputObject $_ -MemberType AliasProperty -Name DeletionTimestamp -Value DeletedDateTime
                Add-Member -InputObject $_ -MemberType AliasProperty -Name InformationalUrls -Value Info
                $propsToConvert = @(
                    'AddIns', 'Logo', 'AppRoles', 'GroupMembershipClaims', 'IdentifierUris', 'Info',
                    'IsDeviceOnlyAuthSupported', 'KeyCredentials', 'Oauth2RequirePostResponse', 'OptionalClaims',
                    'ParentalControlSettings', 'PasswordCredentials', 'Api', 'PublicClient',
                    'PublisherDomain', 'Web', 'RequiredResourceAccess', 'SignInAudience')
                try {
                    foreach ($prop in $propsToConvert) {
                        if ($prop -eq 'AppRoles') {
                            $myAppRoles = New-Object System.Collections.Generic.List[Microsoft.Open.AzureAD.Model.AppRole]
                            foreach ($appRole in $_.$prop) {
                                $hash = New-Object Microsoft.Open.AzureAD.Model.AppRole
                                foreach ($propertyName in $hash.psobject.Properties.Name) {
                                    $hash.$propertyName = $appRole.$propertyName
                                }
                                $myAppRoles.Add($hash)
                            }
                            $_ | Add-Member -MemberType NoteProperty -Name $prop -Value ($myAppRoles) -Force
                        }
                        else {
                            $value = $_.$prop | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                            $_ | Add-Member -MemberType NoteProperty -Name $prop -Value ($value) -Force
                        }
                    }
                }
                catch {}
            }
            foreach ($credType in @('KeyCredentials', 'PasswordCredentials')) {
                if ($null -ne $_.PSObject.Properties[$credType]) {
                    $_.$credType | ForEach-Object {
                        try {
                            if ($null -ne $_.EndDateTime -or $null -ne $_.StartDateTime) {
                                Add-Member -InputObject $_ -MemberType NoteProperty -Name EndDate -Value $_.EndDateTime
                                Add-Member -InputObject $_ -MemberType NoteProperty -Name StartDate -Value $_.StartDateTime
                                $_.PSObject.Properties.Remove('EndDateTime')
                                $_.PSObject.Properties.Remove('StartDateTime')
                            }
                        }
                        catch {}
                    }
                }
            }
        }

        $response
    }        
}

