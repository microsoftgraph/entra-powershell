BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgDirectoryRoleMemberByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Add-EntraDirectoryRoleMember" {
    Context "Test for Add-EntraDirectoryRoleMember" {
        It "Should return empty object" {
            $result = Add-EntraDirectoryRoleMember -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -RefObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgDirectoryRoleMemberByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Add-EntraDirectoryRoleMember -ObjectId  -RefObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"  } | Should -Throw "Missing an argument for parameter 'ObjectId'.*"
        }
        It "Should fail when ObjectId is invalid" {
            { Add-EntraDirectoryRoleMember -ObjectId "" -RefObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when RefObjectId is empty" {
            { Add-EntraDirectoryRoleMember -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -RefObjectId   } | Should -Throw "Missing an argument for parameter 'RefObjectId'.*"
        }
        It "Should fail when RefObjectId is invalid" {
            { Add-EntraDirectoryRoleMember -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -RefObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }
        It "Should contain DirectoryRoleId in parameters when passed ObjectId to it" {
            Mock -CommandName New-MgDirectoryRoleMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Add-EntraDirectoryRoleMember -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -RefObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result
            $params.DirectoryRoleId | Should -Be "468cf92a-f38b-44a1-8007-3ca3c1dcea99"
        }
        It "Should contain OdataId in parameters when passed RefObjectId to it" {
            Mock -CommandName New-MgDirectoryRoleMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Add-EntraDirectoryRoleMember -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -RefObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result
            $value="https://graph.microsoft.com/v1.0/directoryObjects/"
            $params.OdataId | Should -Be $value"996d39aa-fdac-4d97-aa3d-c81fb47362ac"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgDirectoryRoleMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraDirectoryRoleMember"
            $result = Add-EntraDirectoryRoleMember -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -RefObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }

}        