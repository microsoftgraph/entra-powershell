# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName   = "New-AzureADPolicy"
    TargetName   = $null
    Parameters   = $null
    Outputs      = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Type"] = $Type        
        $respType = $null

        if($params.type -eq "activityBasedTimeoutPolicy" ) {
            $params.type  = "activityBasedTimeoutPolicies"    
            $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGrphActivityBasedTimeoutPolicy    
        }
        elseif ($params.type -eq "appManagementPolicy") {
            $params.type = "appManagementPolicies"
            $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphAppManagementPolicy
        }
        elseif ($params.type -eq "claimsMappingPolicies") {
             $params.type = "claimsMappingPolicies"         
             $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphClaimsMappingPolicy     
        } 
        elseif ($params.type -eq "featureRolloutPolicy") {
            $params.type = "featureRolloutPolicies"
            $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphFeatureRolloutPolicy   
        }
        elseif ($params.type -eq "HomeRealmDiscoveryPolicy") {
             $params.type = "homeRealmDiscoveryPolicies"
             $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphHomeRealmDiscoveryPolicy 
        }
        elseif ($params.type -eq "tokenIssuancePolicy") {
            $params.type = "tokenIssuancePolicies"
            $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphTokenIssuancePolicy   
        }
        elseif ($params.type -eq "tokenLifetimePolicy") {
            $params.type = "tokenLifetimePolicies"
            $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphTokenLifetimePolicy 
        }
        elseif ($params.type -eq "permissionGrantPolicy") {
            $params.type = "permissionGrantPolicies"
            $respType = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphPermissionGrantPolicy 
        }

        $params["Uri"] = "https://graph.microsoft.com/beta/policies/" + $params.type
        $Definition =$PSBoundParameters["Definition"]
        $DisplayName=$PSBoundParameters["DisplayName"]
        $AlternativeIdentifier = $PSBoundParameters["AlternativeIdentifier"]
        $KeyCredentials = $PSBoundParameters["KeyCredentials"]
        $IsOrganizationDefault =$PSBoundParameters["IsOrganizationDefault"]
        $params["Method"] = "POST"
       
        $body = @{
            Definition = $Definition
            DisplayName = $DisplayName
            IsOrganizationDefault = $IsOrganizationDefault
            AlternativeIdentifier =$AlternativeIdentifier
            KeyCredentials = $KeyCredentials
            Type = $Type
        }
        $body = $body | ConvertTo-Json
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
	    if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")


        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params.uri -Method $params.method -Body $body | ConvertTo-Json | ConvertFrom-Json
       
        $response.PSObject.Properties | ForEach-Object {
            $propertyName = $_.Name
            $propertyValue = $_.Value
            $respType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
    
        }
            
        $respType
    }    
'@
}


