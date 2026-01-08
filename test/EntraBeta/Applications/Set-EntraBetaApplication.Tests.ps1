# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaApplication -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "Set-EntraBetaApplication" {
    Context "Test for Set-EntraBetaApplication" {
        It "Should return empty object" {
            $result = Set-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000" -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty 
            Should -Invoke -CommandName Update-MgBetaApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Set-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000" -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty 
            Should -Invoke -CommandName Update-MgBetaApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should fail when ApplicationId is empty" {
            { Set-EntraBetaApplication -ApplicationId "" } | Should -Throw "Cannot bind argument to parameter 'ApplicationId' because it is an empty string."
        }
        It "Should fail when invalid parameter is passed" {
            { Set-EntraBetaApplication -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }
        It "Should contain ApplicationId in parameters when passed ApplicationId to it" {
            Mock -CommandName Update-MgBetaApplication -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Applications
            $result = Set-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000"
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "aaaaaaaa-1111-1111-1111-000000000000"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaApplication"
            $result = Set-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaApplication"
            Should -Invoke -CommandName Update-MgBetaApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
        It "Should set PreAuthorizedApplications parameter and create Api object with correct structure" {
            Mock -CommandName Update-MgBetaApplication -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Applications
            
            $preAuthApp = New-Object Microsoft.Open.MSGraph.Model.PreAuthorizedApplication
            $preAuthApp.AppId = "bbbbbbbb-2222-2222-2222-000000000000"
            $preAuthApp.PermissionIds = @("cccccccc-3333-3333-3333-000000000000")
            
            $result = Set-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000" -PreAuthorizedApplications @($preAuthApp)
            $params = Get-Parameters -data $result
            
            $params.Api | Should -Not -BeNullOrEmpty
            $params.Api.PreAuthorizedApplications | Should -Not -BeNullOrEmpty
            $params.Api.PreAuthorizedApplications.Count | Should -Be 1
            $preAuthEntry = $params.Api.PreAuthorizedApplications[0]
            $preAuthEntry.AppId | Should -Be "bbbbbbbb-2222-2222-2222-000000000000"
            $preAuthEntry.PermissionIds | Should -Contain "cccccccc-3333-3333-3333-000000000000"
        }

        It "Should handle multiple PreAuthorizedApplications with correct structure" {
            Mock -CommandName Update-MgBetaApplication -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Applications
            
            $preAuthApp1 = New-Object Microsoft.Open.MSGraph.Model.PreAuthorizedApplication
            $preAuthApp1.AppId = "bbbbbbbb-2222-2222-2222-000000000000"
            $preAuthApp1.PermissionIds = @("cccccccc-3333-3333-3333-000000000000")
            
            $preAuthApp2 = New-Object Microsoft.Open.MSGraph.Model.PreAuthorizedApplication
            $preAuthApp2.AppId = "dddddddd-4444-4444-4444-000000000000"
            $preAuthApp2.PermissionIds = @("eeeeeeee-5555-5555-5555-000000000000")
            
            $result = Set-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000" -PreAuthorizedApplications @($preAuthApp1, $preAuthApp2)
            $params = Get-Parameters -data $result
            
            $params.Api | Should -Not -BeNullOrEmpty
            $params.Api.PreAuthorizedApplications | Should -Not -BeNullOrEmpty
            $params.Api.PreAuthorizedApplications.Count | Should -Be 2
            $params.Api.PreAuthorizedApplications[0].AppId | Should -Be "bbbbbbbb-2222-2222-2222-000000000000"
            $params.Api.PreAuthorizedApplications[1].AppId | Should -Be "dddddddd-4444-4444-4444-000000000000"
        }

        It "Should merge PreAuthorizedApplications with existing Api parameter" {
            Mock -CommandName Update-MgBetaApplication -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Applications
            
            $apiApp = New-Object Microsoft.Open.MSGraph.Model.ApiApplication
            $apiApp.RequestedAccessTokenVersion = 2
            
            $preAuthApp = New-Object Microsoft.Open.MSGraph.Model.PreAuthorizedApplication
            $preAuthApp.AppId = "bbbbbbbb-2222-2222-2222-000000000000"
            $preAuthApp.PermissionIds = @("cccccccc-3333-3333-3333-000000000000")
            
            $result = Set-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000" -Api $apiApp -PreAuthorizedApplications @($preAuthApp)
            $params = Get-Parameters -data $result
            
            $params.Api | Should -Not -BeNullOrEmpty
            $params.Api.RequestedAccessTokenVersion | Should -Be 2
            $params.Api.PreAuthorizedApplications | Should -Not -BeNullOrEmpty
            $params.Api.PreAuthorizedApplications[0].AppId | Should -Be "bbbbbbbb-2222-2222-2222-000000000000"
        }

        It "Should handle PreAuthorizedApplications with multiple permissions" {
            Mock -CommandName Update-MgBetaApplication -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Applications
            
            $preAuthApp = New-Object Microsoft.Open.MSGraph.Model.PreAuthorizedApplication
            $preAuthApp.AppId = "bbbbbbbb-2222-2222-2222-000000000000"
            $preAuthApp.PermissionIds = @("cccccccc-3333-3333-3333-000000000000", "dddddddd-4444-4444-4444-000000000000")
            
            $result = Set-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000" -PreAuthorizedApplications @($preAuthApp)
            $params = Get-Parameters -data $result
            
            $preAuthEntry = $params.Api.PreAuthorizedApplications[0]
            $preAuthEntry.PermissionIds.Count | Should -Be 2
            $preAuthEntry.PermissionIds | Should -Contain "cccccccc-3333-3333-3333-000000000000"
            $preAuthEntry.PermissionIds | Should -Contain "dddddddd-4444-4444-4444-000000000000"
        }
    }
}

