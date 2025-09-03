# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Reports) -eq $null) {
        Import-Module Microsoft.Entra.Reports        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraAuditSignInLog with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                conditionalAccessStatus  =      'success'
                userId                   =      'bbbbbbbb-1111-2222-3333-cccccccccccc'
                riskLevelDuringSignIn     =     'none'
                userPrincipalName        =      'test@m365x99297270.onmicrosoft.com'
                resourceDisplayName       =     'Windows Azure Active SignIn'
                riskEventTypes_v2        =      @{}
                ipAddress                =      '2409:40c2:401d:1cab:9464:4580:6282:b375'
                status                   =      @{}
                clientAppUsed            =      'Mobile Apps and Desktop clients'
                isInteractive           =       'True'
                createdDateTime         =       '06/21/2024 7:07:42 am'
                correlationId           =       'bbbbbbbb-1111-2222-3333-cccccccccc11'
                userDisplayName        =        'MOD Administrator'
                location              =         @{}
                riskDetail             =        'none'
                appDisplayName          =       'Azure Active SignIn PowerShell'
                id                          =   'bbbbbbbb-1111-2222-3333-cccccccccc22'
                appliedConditionalAccessPolicies =@{}
                deviceDetail               =    @{}
                riskLevelAggregated         =   'none'
                appId                       =   'bbbbbbbb-1111-2222-3333-cccccccccc55'
                resourceId                  =   'bbbbbbbb-1111-2222-3333-cccccccccc66'
                riskEventTypes              =   @{}
                riskState                  =    'none'
            }
        )
    }

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes      = @('AuditLog.Read.All', 'Directory.Read.All')
        }
    } -ModuleName Microsoft.Entra.Reports

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Reports
}
  
Describe "Get-EntraAuditSignInLog" {
    Context "Test for Get-EntraAuditSignInLog" {
        It "Should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Reports
            { Get-EntraAuditSignInLog -SignInId "bbbbbbbb-1111-2222-3333-cccccccccc22" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Reports -Times 0
        }
        
        It "Should return specific Audit SignIn Logs" {
            $result = Get-EntraAuditSignInLog -SignInId "bbbbbbbb-1111-2222-3333-cccccccccc22"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccc22'
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Reports -Times 1
        }    
        It "Should return specific Audit SignIn Logs with alias" {
            $result = Get-EntraAuditSignInLog -Id "bbbbbbbb-1111-2222-3333-cccccccccc22"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccc22'
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Reports -Times 1
        }        
        It "Should fail when SignInId is empty" {
            { Get-EntraAuditSignInLog -SignInId } | Should -Throw "Missing an argument for parameter 'SignInId'*"
        }       
        It "Should fail when filter is empty" {
            { Get-EntraAuditSignInLog -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should fail when Top is empty" {
            { Get-EntraAuditSignInLog -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraAuditSignInLog -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return all Audit SignIn Logs" {
            $result = Get-EntraAuditSignInLog -All 
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Reports -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraAuditSignInLog -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }
        It "Should return specific Audit SignIn Logs by filter" {
            $result = Get-EntraAuditSignInLog -Filter "correlationId eq 'bbbbbbbb-1111-2222-3333-cccccccccc11'"
            $result | Should -Not -BeNullOrEmpty
            $result.id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccc22'
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Reports -Times 1
        }  
        It "Should return top Audit SignIn Logs" {
            $result = @(Get-EntraAuditSignInLog -Top 1)
            $result | Should -Not -BeNullOrEmpty
            $result | Should -HaveCount 1
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Reports -Times 1
        }
        It "Should contain ID in parameters when passed Id to it" {
            $result = Get-EntraAuditSignInLog -SignInId "bbbbbbbb-1111-2222-3333-cccccccccc22"
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc22"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Entra.Reports
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAuditSignInLog"
            $result =  Get-EntraAuditSignInLog -SignInId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Reports -Times 1 -ParameterFilter {
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
                { Get-EntraAuditSignInLog -SignInId "bbbbbbbb-1111-2222-3333-cccccccccc22" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}
