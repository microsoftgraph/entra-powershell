BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

$scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                           = "oz6hWDLGrkae4JwNQ81_Pao5bZms_ZdNqj3IH7RzYqw-1"
                    "resourceId"                   = "dddddddd-1111-2222-3333-aaaaaaaaaaaa"
                    "status"                       = "Provisioned"
                    "startDateTime"                = "29-05-2024 00:00:00"
                    "endDateTime"                  = $null
                    "linkedEligibleRoleAssignmentId" = $null
                    "memberType"                   = "Direct"
                    "assignmentState"              = "Active"
                    "createdDateTime"              = "16-08-2023 08:25:02" 
                    "subjectId"                    = "aaaaaaaa-fdac-4d97-aa3d-cccccccccccc"
                    "roleDefinitionId"             = "eeeeeeee-c632-46ae-9ee0-dddddddddddd" 
                    "Parameters"                   = $args                
                }
            
            )
            
        }

    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaMSPrivilegedRoleAssignment" {
Context "Test for Get-EntraBetaMSPrivilegedRoleAssignment" {
        It "Should return MS privileged role assignment" {
            $result = Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId "MockRoles" -ResourceId "dddddddd-1111-2222-3333-aaaaaaaaaaaa" -Id "oz6hWDLGrkae4JwNQ81_Pao5bZms_ZdNqj3IH7RzYqw-1"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "oz6hWDLGrkae4JwNQ81_Pao5bZms_ZdNqj3IH7RzYqw-1"
            $result.ResourceId | Should -Be "dddddddd-1111-2222-3333-aaaaaaaaaaaa"
            $result.roleDefinitionId | Should -be "eeeeeeee-c632-46ae-9ee0-dddddddddddd"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            {Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId "MockRoles" -ResourceId "dddddddd-1111-2222-3333-aaaaaaaaaaaa" -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId "MockRoles" -ResourceId "dddddddd-1111-2222-3333-aaaaaaaaaaaa" -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when ProviderId is empty" {
            {Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId   -ResourceId "dddddddd-1111-2222-3333-aaaaaaaaaaaa" -Id "oz6hWDLGrkae4JwNQ81_Pao5bZms_ZdNqj3IH7RzYqw-1"  } | Should -Throw "Missing an argument for parameter 'ProviderId'*"
        }
        It "Should fail when ProviderId is invalid" {
            { Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId "" -ResourceId "dddddddd-1111-2222-3333-aaaaaaaaaaaa" -Id "oz6hWDLGrkae4JwNQ81_Pao5bZms_ZdNqj3IH7RzYqw-1" } | Should -Throw "Cannot bind argument to parameter 'ProviderId' because it is an empty string."
        }
        It "Should fail when ResourceId is empty" {
            {Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId "MockRoles" -ResourceId  -Id "oz6hWDLGrkae4JwNQ81_Pao5bZms_ZdNqj3IH7RzYqw-1" } | Should -Throw "Missing an argument for parameter 'ResourceId'*"
        }
        It "Should fail when ResourceId is invalid" {
            { Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId "MockRoles" -ResourceId "" -Id "oz6hWDLGrkae4JwNQ81_Pao5bZms_ZdNqj3IH7RzYqw-1" } | Should -Throw "Cannot bind argument to parameter 'ResourceId' because it is an empty string."
        }
        It "Should return top MS privileged role assignment" {
            $result = Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId "MockRoles" -ResourceId "dddddddd-1111-2222-3333-aaaaaaaaaaaa" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId "MockRoles" -ResourceId "dddddddd-1111-2222-3333-aaaaaaaaaaaa" -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId "MockRoles" -ResourceId "dddddddd-1111-2222-3333-aaaaaaaaaaaa" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return specific MS privileged role assignment by filter" {
            $result = Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId "MockRoles" -ResourceId "dddddddd-1111-2222-3333-aaaaaaaaaaaa" -Filter "id eq 'oz6hWDLGrkae4JwNQ81_Pao5bZms_ZdNqj3IH7RzYqw-1'"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'oz6hWDLGrkae4JwNQ81_Pao5bZms_ZdNqj3IH7RzYqw-1'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId "MockRoles" -ResourceId "dddddddd-1111-2222-3333-aaaaaaaaaaaa" -Filter  } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaMSPrivilegedRoleAssignment"

            $result = Get-EntraBetaMSPrivilegedRoleAssignment -ProviderId "MockRoles" -ResourceId "dddddddd-1111-2222-3333-aaaaaaaaaaaa"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}    