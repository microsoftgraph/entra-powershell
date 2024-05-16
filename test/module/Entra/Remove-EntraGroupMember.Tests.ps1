BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Parameters"      = $args
            }
        )
    }  
    Mock -CommandName Remove-MgGroupMemberByRef -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraGroupMember" {
    Context "Test for Remove-EntraGroupMember" {
        It "Should return empty object" {
            $result = Remove-EntraGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgGroupMemberByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraGroupMember -ObjectId -MemberId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e" } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   

        It "Should fail when ObjectId is invalid" {
            { Remove-EntraGroupMember -ObjectId "" -MemberId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should fail when MemberId is empty" {
            { Remove-EntraGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'*"
        }   

        It "Should fail when MemberId is invalid" {
            { Remove-EntraGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId "" } | Should -Throw "Cannot bind argument to parameter 'MemberId' because it is an empty string."
        }   

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            $result = Remove-EntraGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroupMember"

            $result = Remove-EntraGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}