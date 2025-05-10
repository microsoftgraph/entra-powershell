# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"         = "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
                "Parameters" = $args
            }
        )
    }  

    Mock -CommandName Get-MgServicePrincipalMemberOf -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
}

Describe "Select-EntraGroupIdsServicePrincipalIsMemberOf" {
    Context "Test for Select-EntraGroupIdsServicePrincipalIsMemberOf" {
        It "Should Selects the groups in which a service principal is a member." {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = @("22cc22cc-dd33-ee44-ff55-66aa66aa66aa", "33dd33dd-ee44-ff55-aa66-77bb77bb77bb", "44ee44ee-ff55-aa66-bb77-88cc88cc88cc")
            $SPId = "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
            $result = Select-EntraGroupIdsServicePrincipalIsMemberOf -ServicePrincipalId $SPId -GroupIdsForMembershipCheck $Groups
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgServicePrincipalMemberOf -ModuleName Microsoft.Entra.Applications -Times 1
        }    
        It "Should fail when ObjectID parameter is empty" {
            { Select-EntraGroupIdsServicePrincipalIsMemberOf -ServicePrincipalId -GroupIdsForMembershipCheck "22cc22cc-dd33-ee44-ff55-66aa66aa66aa" } | Should -Throw "Missing an argument for parameter*"
        }
        It "Should fail when ObjectID parameter is invalid" {
            { Select-EntraGroupIdsServicePrincipalIsMemberOf -ServicePrincipalId "" -GroupIdsForMembershipCheck "22cc22cc-dd33-ee44-ff55-66aa66aa66aa" } | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }  
        It "Should fail when GroupIdsForMembershipCheck parameter is empty" {
            $SPId = "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
            { Select-EntraGroupIdsServicePrincipalIsMemberOf -ServicePrincipalId $SPId -GroupIdsForMembershipCheck } | Should -Throw "Missing an argument for parameter 'GroupIdsForMembershipCheck'.*"
        }
        It "Should fail when GroupIdsForMembershipCheck parameter is invalid" {
            { Select-EntraGroupIdsServicePrincipalIsMemberOf -ServicePrincipalId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -GroupIdsForMembershipCheck "" } | Should -Throw "Cannot process argument transformation on parameter 'GroupIdsForMembershipCheck'*"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Select-EntraGroupIdsServicePrincipalIsMemberOf"
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = @("22cc22cc-dd33-ee44-ff55-66aa66aa66aa", "33dd33dd-ee44-ff55-aa66-77bb77bb77bb", "44ee44ee-ff55-aa66-bb77-88cc88cc88cc")
            $SPId = "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
            $result = Select-EntraGroupIdsServicePrincipalIsMemberOf -ServicePrincipalId $SPId -GroupIdsForMembershipCheck $Groups
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Select-EntraGroupIdsServicePrincipalIsMemberOf"

            Should -Invoke -CommandName Get-MgServicePrincipalMemberOf -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = @("22cc22cc-dd33-ee44-ff55-66aa66aa66aa", "33dd33dd-ee44-ff55-aa66-77bb77bb77bb", "44ee44ee-ff55-aa66-bb77-88cc88cc88cc")
            $SPId = "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Select-EntraGroupIdsServicePrincipalIsMemberOf -ServicePrincipalId $SPId -GroupIdsForMembershipCheck $Groups -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

