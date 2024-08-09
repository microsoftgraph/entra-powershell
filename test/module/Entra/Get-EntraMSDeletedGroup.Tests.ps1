BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "056b2531-005e-4f3e-be78-01a71ea30a04"
              "DeletedDateTime"              = "10-05-2024 04:27:17"
              "CreatedDateTime"              = "07-07-2023 14:31:41"
              "DisplayName"                  = "Mock-App"
              "MailNickname"                 = "Demo-Mock-App"
              "GroupTypes"                   = "Unified"
              "SecurityEnabled"              = $False
              "MailEnabled"                  = $True
              "Visibility"                   = "Public"
              "AdditionalProperties"         = @{"@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#groups/$entity"}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgDirectoryDeletedItemAsGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraMSDeletedGroup" {
Context "Test for Get-EntraMSDeletedGroup" {
        It "Should return specific MS Deleted Group" {
            $result = Get-EntraMSDeletedGroup -Id "056b2531-005e-4f3e-be78-01a71ea30a04"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
            $result.DisplayName | Should -Be "Mock-App"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraMSDeletedGroup -Id    } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraMSDeletedGroup -Id  ""} | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
         It "Should return All MS deleted groups" {
            $result = Get-EntraMSDeletedGroup  -All $true
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraMSDeletedGroup -Id "056b2531-005e-4f3e-be78-01a71ea30a04" -All  } | Should -Throw "Missing an argument for parameter 'All'*"
        }
        It "Should fail when All is invalid" {
            { Get-EntraMSDeletedGroup -Id "056b2531-005e-4f3e-be78-01a71ea30a04" -All xyz } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }
        It "Should return top 1 MS deleted group" {
            $result = Get-EntraMSDeletedGroup -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
            $result.DisplayName | Should -Be "Mock-App"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraMSDeletedGroup -Id "056b2531-005e-4f3e-be78-01a71ea30a04" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraMSDeletedGroup -Id "056b2531-005e-4f3e-be78-01a71ea30a04" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return specific MS deleted group by filter" {
            $result = Get-EntraMSDeletedGroup -Filter "DisplayName eq 'Mock-App'"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
            $result.DisplayName | Should -Be "Mock-App"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraMSDeletedGroup -Filter  } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should return specific MS deleted groupn by SearchString" {
            $result = Get-EntraMSDeletedGroup -SearchString "Demo-Mock-App"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
            $result.MailNickname | Should -Be "Demo-Mock-App"
            $result.DisplayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when searchstring is empty" {
            { Get-EntraMSDeletedGroup -SearchString  } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }

        It "Should contain DirectoryObjectId in parameters when passed Id to it" {              
            $result = Get-EntraMSDeletedGroup -Id "056b2531-005e-4f3e-be78-01a71ea30a04"
            $params = Get-Parameters -data $result.Parameters
            $params.DirectoryObjectId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {              
            $result = Get-EntraMSDeletedGroup -SearchString "Demo-Mock-App"
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Mock-App"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSDeletedGroup"

            $result = Get-EntraMSDeletedGroup -Id "056b2531-005e-4f3e-be78-01a71ea30a04"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}    