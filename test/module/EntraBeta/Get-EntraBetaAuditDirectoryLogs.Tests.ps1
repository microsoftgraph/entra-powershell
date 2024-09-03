# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "InitiatedBy" = [PSCustomObject]@{
                    "App"                  = ""
                    "User"                 = ""
                    "AdditionalProperties" = @{}
                }
                "TargetResources" = [PSCustomObject]@{
                    "DisplayName"          = ""
                    "GroupType"            = ""
                    "Id"                   = "00000000-0000-0000-0000-000000000000"
                    "ModifiedProperties"   = @()
                    "Type"                 = "N/A"
                    "UserPrincipalName"    = ""
                    "AdditionalProperties" = @{}
                }
                "AdditionalDetails"    = ""
                "ActivityDateTime"     = "28-May-24 11:49:02 AM"
                "ActivityDisplayName"  = "GroupsODataV4_GetgroupLifecyclePolicies"
                "Category"             = "GroupManagement"
                "CorrelationId"        = "aaaabbbb-0000-cccc-1111-dddd2222eeee"
                "Id"                   = "bbbbcccc-1111-dddd-2222-eeee3333ffff"
                "LoggedByService"      = "Self-service Group Management"
                "OperationType"        = "Update"
                "Result"               = "success"
                "ResultReason"         = "OK"
                "UserAgent"            = ""
                "AdditionalProperties" = @{}
                "Parameters"           = $args
            }
        )
    }    
    Mock -CommandName Get-MgBetaAuditLogDirectoryAudit -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "Get-EntraBetaAuditDirectoryLogs" {
    Context "Test for Get-EntraBetaAuditDirectoryLogs" {
        It "Should get all logs" {
            $result = Get-EntraBetaAuditDirectoryLogs -All
            $result | Should -Not -BeNullOrEmpty            
            Should -Invoke -CommandName Get-MgBetaAuditLogDirectoryAudit -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All has argument" {
            { Get-EntraBetaAuditDirectoryLogs -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        } 
        
        It "Should get first n logs" {
            $result = Get-EntraBetaAuditDirectoryLogs -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.ActivityDateTime | Should -Be "28-May-24 11:49:02 AM"
            $result.ActivityDisplayName | Should -Be "GroupsODataV4_GetgroupLifecyclePolicies"
            $result.Category | Should -Be "GroupManagement"
            $result.CorrelationId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result.Id | Should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result.LoggedByService | Should -Be "Self-service Group Management"

            Should -Invoke -CommandName Get-MgBetaAuditLogDirectoryAudit -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraBetaAuditDirectoryLogs -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraBetaAuditDirectoryLogs -Top y } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Should get audit logs containing a given ActivityDisplayName" {
            $result = Get-EntraBetaAuditDirectoryLogs -Filter "ActivityDisplayName eq 'GroupsODataV4_GetgroupLifecyclePolicies'" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.ActivityDateTime | Should -Be "28-May-24 11:49:02 AM"
            $result.ActivityDisplayName | Should -Be "GroupsODataV4_GetgroupLifecyclePolicies"
            $result.Category | Should -Be "GroupManagement"
            $result.CorrelationId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result.Id | Should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result.LoggedByService | Should -Be "Self-service Group Management"

            Should -Invoke -CommandName Get-MgBetaAuditLogDirectoryAudit -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when Filter is empty" {
            { Get-EntraBetaAuditDirectoryLogs -Filter -Top 1} | Should -Throw "Missing an argument for parameter 'Filter'*"
        }  

        It "Should get all audit logs with a given result(success)" {
            $result = Get-EntraBetaAuditDirectoryLogs -Filter "result eq 'success'"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaAuditLogDirectoryAudit -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should get all audit logs with a given result(failure)" {
            $result = Get-EntraBetaAuditDirectoryLogs -Filter "result eq 'failure'" -All
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaAuditLogDirectoryAudit -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAuditDirectoryLogs"
            $result = Get-EntraBetaAuditDirectoryLogs -All
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }  
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaAuditDirectoryLogs -Top 1 -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}