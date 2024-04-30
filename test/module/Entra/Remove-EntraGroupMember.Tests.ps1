BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgGroupMemberByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraGroupMember" {
    Context "Test for Remove-EntraGroupMember" {
        It "Should return empty object" {
            $result = Remove-EntraGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgGroupMemberByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when parameter is invalid" {
            { Remove-EntraGroupMember -ObjectId "" -MemberId "" } | Should -Throw "Cannot bind argument to parameter*"
        } 
        It "Should fail when parameter is invalid" {
            { Remove-EntraGroupMember -ObjectId  -MemberId  } | Should -Throw "Missing an argument for parameter 'ObjectId'.*"
        } 
        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgGroupMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }
        It "Should contain DirectoryObjectId in parameters when passed MemberId to it" {
            Mock -CommandName Remove-MgGroupMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgGroupMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroupMember"

            $result = Remove-EntraGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }  
    }
}