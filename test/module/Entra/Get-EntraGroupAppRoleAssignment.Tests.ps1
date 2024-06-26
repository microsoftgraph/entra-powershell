BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
              "AppRoleId"                    = "edaa71bf-f833-4989-8316-82d11fc811e5"
              "CreatedDateTime"              = "06-05-2024 05:42:01"
              "DeletedDateTime"              = $null
              "PrincipalDisplayName"         = "Mock-Group"
              "PrincipalId"                  = "524b5373-7121-4e66-9c3f-a363d11a08c8"
              "ResourceId"                   = "4a795157-504b-4473-ae28-1c54592e7702"
              "ResourceDisplayName"          = "Mock-Group"
              "PrincipalType"                = "PrincipalType"
              "AdditionalProperties"         = @{}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgGroupAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraGroupAppRoleAssignment" {
Context "Test for New-EntraGroupAppRoleAssignment" {
        It "Should return specific Group AppRole Assignment" {
            $result = Get-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $result.ResourceId | Should -Be "4a795157-504b-4473-ae28-1c54592e7702"
            $result.PrincipalId | Should -Be "524b5373-7121-4e66-9c3f-a363d11a08c8"
            $result.AppRoleId | Should -Be "edaa71bf-f833-4989-8316-82d11fc811e5"


            Should -Invoke -CommandName Get-MgGroupAppRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { Get-EntraGroupAppRoleAssignment -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectlId is invalid" {
            { Get-EntraGroupAppRoleAssignment -ObjectId ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return All Group AppRole Assignment" {
            $result = Get-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8" -All $true
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $result.ResourceId | Should -Be "4a795157-504b-4473-ae28-1c54592e7702"
            $result.PrincipalId | Should -Be "524b5373-7121-4e66-9c3f-a363d11a08c8"
            $result.AppRoleId | Should -Be "edaa71bf-f833-4989-8316-82d11fc811e5"


            Should -Invoke -CommandName Get-MgGroupAppRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8" -All  } | Should -Throw "Missing an argument for parameter 'All'*"
        }
        It "Should fail when All is invalid" {
            { Get-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8" -All xyz } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }
        It "Should return top 1 Group AppRole Assignment" {
            $result = Get-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $result.ResourceId | Should -Be "4a795157-504b-4473-ae28-1c54592e7702"
            $result.PrincipalId | Should -Be "524b5373-7121-4e66-9c3f-a363d11a08c8"
            $result.AppRoleId | Should -Be "edaa71bf-f833-4989-8316-82d11fc811e5"


            Should -Invoke -CommandName Get-MgGroupAppRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Result should Contain ObjectId" {
            $result = Get-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"
            $result.ObjectId | should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
        }
        It "Should contain GroupId in parameters when passed Id to it" {              
            $result = Get-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "524b5373-7121-4e66-9c3f-a363d11a08c8"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroupAppRoleAssignment"

            $result = Get-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}
 