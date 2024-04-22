BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgDirectoryRoleMemberByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraDirectoryRoleMember" {
    Context "Test for Remove-EntraDirectoryRoleMember" {
        It "Should return empty object" {
            $result = Remove-EntraDirectoryRoleMember -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -MemberId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDirectoryRoleMemberByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }   
        It "Should fail when ObjectId is empty" {
            { Remove-EntraDirectoryRoleMember -ObjectId  -MemberId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraDirectoryRoleMember -ObjectId "" -MemberId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when MemberId is empty" {
            { Remove-EntraDirectoryRoleMember -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -MemberId   } | Should -Throw "Missing an argument for parameter 'MemberId'*"
        }
        It "Should fail when MemberId is invalid" {
            { Remove-EntraDirectoryRoleMember -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -MemberId ""  } | Should -Throw "Cannot bind argument to parameter 'MemberId' because it is an empty string."
        }
        It "Should contain DirectoryRoleId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgDirectoryRoleMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraDirectoryRoleMember -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -MemberId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result
            $params.DirectoryRoleId | Should -Be "468cf92a-f38b-44a1-8007-3ca3c1dcea99"
        }
        It "Should contain DirectoryObjectId in parameters when passed RefObjectId to it" {
            Mock -CommandName Remove-MgDirectoryRoleMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraDirectoryRoleMember -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -MemberId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgDirectoryRoleMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDirectoryRoleMember"
            $result = Remove-EntraDirectoryRoleMember -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -MemberId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }   
}
