# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName   = "New-AzureADPolicy"
    TargetName   = $null
    Parameters   = $null
    Outputs      = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$customHeaders = New-EntraBetaCustomHeaders -Command `$MyInvocation.MyCommand
        `$params["Type"] = `$Type

        if(`$params.type -eq "activityBasedTimeoutPolicy" ) {
            `$params.type  = "activityBasedTimeoutPolicies"
        }
        elseif (`$params.type -eq "appManagementPolicy") {
         `$params.type = "appManagementPolicies"
        }
        elseif (`$params.type -eq "claimsMappingPolicies") {
             `$params.type = "claimsMappingPolicies"
        }
        elseif (`$params.type -eq "featureRolloutPolicy") {
            `$params.type = "featureRolloutPolicies"
        }
        elseif (`$params.type -eq "HomeRealmDiscoveryPolicy") {
             `$params.type = "homeRealmDiscoveryPolicies"
        }
        elseif (`$params.type -eq "tokenIssuancePolicy") {
            `$params.type = "tokenIssuancePolicies"
        }
        elseif (`$params.type -eq "tokenLifetimePolicy") {
            `$params.type = "tokenLifetimePolicies"
        }
        elseif (`$params.type -eq "permissionGrantPolicy") {
            `$params.type = "permissionGrantPolicies"
        }
        `$params["Uri"] = "https://graph.microsoft.com/beta/policies/" + `$params.type
        `$Definition =`$PSBoundParameters["Definition"]
        `$DisplayName=`$PSBoundParameters["DisplayName"]
        `$AlternativeIdentifier = `$PSBoundParameters["AlternativeIdentifier"]
        `$KeyCredentials = `$PSBoundParameters["KeyCredentials"]
        `$IsOrganizationDefault =`$PSBoundParameters["IsOrganizationDefault"]
        `$params["Method"] = "POST"
       
        `$body = @{
            Definition = `$Definition
            DisplayName = `$DisplayName
            IsOrganizationDefault = `$IsOrganizationDefault
            AlternativeIdentifier =`$AlternativeIdentifier
            KeyCredentials = `$KeyCredentials
            Type = `$Type
        }
        `$body = `$body | ConvertTo-Json
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================``n")


        `$response = Invoke-GraphRequest -Headers `$customHeaders -Uri `$params.uri -Method `$params.method -Body `$body
        `$response.Add("KeyCredentials", "`$KeyCredentials")
        `$response.Add("Type", "`$type")
        
        
        `$CustomTable = [PSCustomObject]@{
            'Id' = `$response.id
            'DisplayName' =  `$response.displayname
            'Type' = `$Type
            'IsOrganizationDefault' = `$response.IsOrganizationDefault
            'Definition' = `$response.definition
        }
        `$CustomTable | Format-Table -AutoSize
    
    }
        
"@
}