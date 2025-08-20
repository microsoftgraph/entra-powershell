# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraGroup with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "DisplayName"     = "demo"
                "Id"              = "aaaaaaaa-1111-2222-3333-cccccccccccc"
                "MailEnabled"     = "False"
                "Description"     = "test"
                "MailNickname"    = "demoNickname"
                "SecurityEnabled" = "True"
                "Parameters"      = $args
            }
        )
    }

    Mock -CommandName Get-MgGroup -MockWith $scriptblock -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("GroupMember.Read.All") } } -ModuleName Microsoft.Entra.Groups
}
  
Describe "Get-EntraGroup" {
    Context "Test for Get-EntraGroup" {
        # It "Should return specific group" {
        #     $result = Get-EntraGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
        #     $result | Should -Not -BeNullOrEmpty
        #     $result.Id | should -Be 'aaaaaaaa-1111-2222-3333-cccccccccccc'

        #     Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        # }       
        # It "Should fail when GroupId is empty" {
        #     { Get-EntraGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        # }
        # It "Should fail when searchstring is empty" {
        #     { Get-EntraGroup -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        # } 
        # It "Should fail when filter is empty" {
        #     { Get-EntraGroup -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        # }
        # It "Should fail when Top is empty" {
        #     { Get-EntraGroup -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        # }
        # It "Should fail when Top is invalid" {
        #     { Get-EntraGroup -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        # }
        # It "Should return all group" {
        #     $result = Get-EntraGroup -All
        #     $result | Should -Not -BeNullOrEmpty            
            
        #     Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        # }
        # It "Should fail when All has an argument" {
        #     { Get-EntraGroup -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        # }           
        # It "Should return specific group by searchString" {
        #     $result = Get-EntraGroup -SearchString 'demo'
        #     $result | Should -Not -BeNullOrEmpty
        #     $result.DisplayName | should -Be 'demo'

        #     Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        # } 
        # It "Should return specific group by filter" {
        #     $result = Get-EntraGroup -Filter "DisplayName -eq 'demo'"
        #     $result | Should -Not -BeNullOrEmpty
        #     $result.DisplayName | should -Be 'demo'

        #     Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        # }  
        # It "Should return top group" {
        #     $result = Get-EntraGroup -Top 1
        #     $result | Should -Not -BeNullOrEmpty

        #     Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        # }  
        # It "Result should Contain ObjectId" {
        #     $result = Get-EntraGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
        #     $result.ObjectId | should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        # } 
        # It "Should contain GroupId in parameters when passed GroupId to it" {
        #     $result = Get-EntraGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
        #     $params = Get-Parameters -data $result.Parameters
        #     $params.GroupId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        # }
        # It "Should contain Filter in parameters when passed SearchString to it" {
        #     $result = Get-EntraGroup -SearchString 'demo'
        #     $params = Get-Parameters -data $result.Parameters
        #     $params.Filter | Should -Match "demo"
        # }
        # It "Should contain 'User-Agent' header" {
        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroup"
        #     $result = Get-EntraGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
        #     $result | Should -Not -BeNullOrEmpty
        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroup"
        #     Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
        #         $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
        #         $true
        #     }
        # }
        # It "Should execute successfully without throwing an error " {
        #     # Disable confirmation prompts       
        #     $originalDebugPreference = $DebugPreference
        #     $DebugPreference = 'Continue'
    
        #     try {
        #         # Act & Assert: Ensure the function doesn't throw an exception
        #         { Get-EntraGroup -SearchString 'demo' -Debug } | Should -Not -Throw
        #     }
        #     finally {
        #         # Restore original confirmation preference            
        #         $DebugPreference = $originalDebugPreference        
        #     }
        # }   
    }
}

