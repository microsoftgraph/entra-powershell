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
                "CorrelationId"        = "267fe77d-a734-48e2-9b5f-9f60c8e0d787"
                "Id"                   = "SSGM_267fe77d-a734-48e2-9b5f-9f60c8e0d787_2WRBW_14273785"
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
            $result = Get-EntraBetaAuditDirectoryLogs -All $true
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgBetaAuditLogDirectoryAudit -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraBetaAuditDirectoryLogs -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }      

        It "Should fail when All is invalid" {
            { Get-EntraBetaAuditDirectoryLogs -All "" } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }      
        
        It "Should get first n logs" {
            $result = Get-EntraBetaAuditDirectoryLogs -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.ActivityDateTime | Should -Be "28-May-24 11:49:02 AM"
            $result.ActivityDisplayName | Should -Be "GroupsODataV4_GetgroupLifecyclePolicies"
            $result.Category | Should -Be "GroupManagement"
            $result.CorrelationId | Should -Be "267fe77d-a734-48e2-9b5f-9f60c8e0d787"
            $result.Id | Should -Be "SSGM_267fe77d-a734-48e2-9b5f-9f60c8e0d787_2WRBW_14273785"
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
            $result.CorrelationId | Should -Be "267fe77d-a734-48e2-9b5f-9f60c8e0d787"
            $result.Id | Should -Be "SSGM_267fe77d-a734-48e2-9b5f-9f60c8e0d787_2WRBW_14273785"
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
            $result = Get-EntraBetaAuditDirectoryLogs -Filter "result eq 'failure'" -All $true
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaAuditLogDirectoryAudit -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAuditDirectoryLogs"
            $result = Get-EntraBetaAuditDirectoryLogs -All $true
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }    
    }
}