# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraAuditDirectoryLogs with parameters: $($args | ConvertTo-Json -Depth 3)"
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

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraAuditDirectoryLogs" {
    Context "Test for Get-EntraAuditDirectoryLogs" {
        It "Should return specific Audit Directory Logs" {
            $result = Get-EntraAuditDirectoryLogs -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccccc'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }        
        It "Should fail when Id is empty" {
            { Get-EntraAuditDirectoryLogs -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }       
        It "Should fail when filter is empty" {
            { Get-EntraAuditDirectoryLogs -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should fail when Top is empty" {
            { Get-EntraAuditDirectoryLogs -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraAuditDirectoryLogs -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return all Audit Directory Logs" {
            $result = Get-EntraAuditDirectoryLogs -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraAuditDirectoryLogs -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }           
        
        It "Should return specific Audit Directory Logs by filter" {
            $result = Get-EntraAuditDirectoryLogs -Filter "correlationId eq 'bbbbbbbb-1111-2222-3333-cccccccccrrr'"
            $result | Should -Not -BeNullOrEmpty
            $result.id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccccc'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should return top Audit Directory Logs" {
            $result = @(Get-EntraAuditDirectoryLogs -Top 1)
            $result | Should -Not -BeNullOrEmpty
            $result | Should -HaveCount 1 

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        
        It "Should contain ID in parameters when passed Id to it" {
            $result = Get-EntraAuditDirectoryLogs -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        
        It "Should contain 'User-Agent' header" {
          

            Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAuditDirectoryLogs"
        $result = Get-EntraAuditDirectoryLogs -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
        $params = Get-Parameters -data $result
        $a= $params | ConvertTo-json | ConvertFrom-Json
        $a.headers.'User-Agent' | Should -Be $userAgentHeaderValue 
        }    
    }
}