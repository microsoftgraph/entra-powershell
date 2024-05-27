BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaGroupMemberByRef -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaGroupMember" {
    Context "Test for Remove-EntraBetaGroupMember" {
        It "Should return empty object" {
            $result = Remove-EntraBetaGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroupMemberByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraBetaGroupMember -ObjectId -MemberId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e" } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   

        It "Should fail when ObjectId is invalid" {
            { Remove-EntraBetaGroupMember -ObjectId "" -MemberId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should fail when MemberId is empty" {
            { Remove-EntraBetaGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'*"
        }   

        It "Should fail when MemberId is invalid" {
            { Remove-EntraBetaGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId "" } | Should -Throw "Cannot bind argument to parameter 'MemberId' because it is an empty string."
        }   

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgBetaGroupMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgBetaGroupMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroupMember"
            $result = Remove-EntraBetaGroupMember -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" -MemberId "a23541ee-4fe9-4cf2-b628-102ebaef8f7e"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}