BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                Id                   = "MSVrBV4APk--eAGnHqMKBDtEqPRvu8xLqWHDSXUhoTE"
                AppRoleId            = "00000000-0000-0000-0000-000000000000"
                CreatedDateTime      = "29-02-2024 05:53:00"
                DeletedDateTime      = ""
                PrincipalDisplayName = "demo"
                PrincipalId          = "056b2531-005e-4f3e-be78-01a71ea30a04"
                PrincipalType        = "Group"
                ResourceDisplayName  = "M365 License Manager"
                ResourceId           = "0008861a-d455-4671-bd24-ce9b3bfce288"
                AdditionalProperties = @{}
                Parameters           = $args
            }
        )

    }

    Mock -CommandName Get-MgUserAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraUserAppRoleAssignment" {
    Context "Test for Get-EntraUserAppRoleAssignment" {
        It "Should return specific User" {
            $result = Get-EntraUserAppRoleAssignment -ObjectId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e"

            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "MSVrBV4APk--eAGnHqMKBDtEqPRvu8xLqWHDSXUhoTE"
            $result.AppRoleId | Should -Be "00000000-0000-0000-0000-000000000000"
            $result.CreatedDateTime | Should -Be "29-02-2024 05:53:00"
            $result.DeletedDateTime | Should -Be ""
            $result.PrincipalDisplayName | Should -Be "demo"
            $result.PrincipalId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
            $result.PrincipalType | Should -Be "Group"
            $result.ResourceDisplayName | Should -Be "M365 License Manager"
            $result.ResourceId | Should -Be "0008861a-d455-4671-bd24-ce9b3bfce288"

            Should -Invoke -CommandName Get-MgUserAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty string value" {
            { Get-EntraUserAppRoleAssignment -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraUserAppRoleAssignment -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'. Specify a parameter of type 'System.String' and try again."
        }

        
        It "Should return all contact" {
            $result = Get-EntraUserAppRoleAssignment -ObjectId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e" -All $true
            $result | Should -Not -BeNullOrEmpty            
            Should -Invoke -CommandName Get-MgUserAppRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraUserAppRoleAssignment -ObjectId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e" -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }

        It "Should fail when All is invalid" {
            { Get-EntraContact -ObjectId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e" -All XY } | Should -Throw  "Cannot process argument transformation on parameter 'All'*"
        }  

        It "Should return top user" {
            $result = Get-EntraUserAppRoleAssignment -ObjectId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgUserAppRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }    

        It "Should fail when top is empty" {
            { Get-EntraUserAppRoleAssignment -ObjectId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraUserAppRoleAssignment -ObjectId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e" -Top HH } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Should contain UserId in parameters when passed ObjectId to it" {
            $result = Get-EntraUserAppRoleAssignment -ObjectId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Match "a23541ee-4fe9-4cf2-b628-102ebaef8f7e"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserAppRoleAssignment"
            $result = Get-EntraUserAppRoleAssignment -ObjectId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }  

    }
}