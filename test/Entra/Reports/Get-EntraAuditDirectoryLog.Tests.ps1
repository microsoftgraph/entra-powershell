# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Reports) -eq $null) {
        Import-Module Microsoft.Entra.Reports        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraAuditDirectoryLog with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                category            = 'DirectoryManagement'
                resultReason        = 'Successfully deleted [0] records for [[LicenseKey:][TenantId:bbbbbbbb-1111-2222-3333-ccccccccccc2][UserName:][UserObjectId:bbbbbbbb-1111-2222-3333-ccccccccccc1][HomeTenantId:bbbbbbbb-1111-2222-3333-cccccccccccc][AzureSovereign:WorldWide]]'
                id                  = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
                operationType       = 'Delete'
                loggedByService     = 'Azure MFA12'
                additionalDetails   = @{ key = 'RequestId'; value = '00000000-0000-0000-0000-000000000000' }
                activityDisplayName = 'DeleteDataFromBackend'
                targetResources     = @(
                    @{
                        userPrincipalName = ''
                        groupType         = ''
                        id                = 'bbbbbbbb-1111-2222-3333-cccccccccaaa'
                        type              = 'User'
                        displayName       = ''
                        modifiedProperties = @()
                    }
                )
                correlationId       = 'bbbbbbbb-1111-2222-3333-cccccccccrrr'
                result              = 'success'
                initiatedBy         = @{ app = ''; user = '' }
                activityDateTime    = '06/19/2024 9:52:22 am'
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
  
Describe "Get-EntraAuditDirectoryLog" {
    Context "Test for Get-EntraAuditDirectoryLog" {
        It "Should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Reports
            { Get-EntraAuditDirectoryLog -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Reports -Times 0
        }
        It "Should return specific Audit Directory Logs" {
            $result = Get-EntraAuditDirectoryLog -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccccc'
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Reports -Times 1
        }        
        It "Should fail when Id is empty" {
            { Get-EntraAuditDirectoryLog -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }       
        It "Should fail when filter is empty" {
            { Get-EntraAuditDirectoryLog -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should fail when Top is empty" {
            { Get-EntraAuditDirectoryLog -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraAuditDirectoryLog -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return all Audit Directory Logs" {
            $result = Get-EntraAuditDirectoryLog -All 
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Reports -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraAuditDirectoryLog -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }           
        
        It "Should return specific Audit Directory Logs by filter" {
            $result = Get-EntraAuditDirectoryLog -Filter "correlationId eq 'bbbbbbbb-1111-2222-3333-cccccccccrrr'"
            $result | Should -Not -BeNullOrEmpty
            $result.id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccccc'
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Reports -Times 1
        }  
        It "Should return top Audit Directory Logs" {
            $result = @(Get-EntraAuditDirectoryLog -Top 1)
            $result | Should -Not -BeNullOrEmpty
            $result | Should -HaveCount 1
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Reports -Times 1
        }        
        It "Should contain ID in parameters when passed Id to it" {
            $result = Get-EntraAuditDirectoryLog -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"            
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }

        It "Should contain 'User-Agent' header" { 
            Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Entra.Reports
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAuditDirectoryLog"
            $result =  Get-EntraAuditDirectoryLog -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
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
                { Get-EntraAuditDirectoryLog -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}
