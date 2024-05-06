BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Set-MgUserManagerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraUserManager" {
    Context "Test for Set-EntraUserManager" {
        It "Should return specific User" {
            $result = Set-EntraUserManager -ObjectId "26bb22db-6b8e-4adb-b761-264c869d5245" -RefObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Set-MgUserManagerByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty string value" {
            { Set-EntraUserManager -ObjectId ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when ObjectId is empty" {
            { Set-EntraUserManager -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should fail when RefObjectId is invalid" {
            { Set-EntraUserManager -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"  RefObjectId ""} | Should -Throw "A positional parameter cannot be found that accepts argument*"
        }

        It "Should contain UserId in parameters when passed ObjectId to it" {
            Mock -CommandName Set-MgUserManagerByRef -MockWith { $args } -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraUserManager -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -RefObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf"
            #  TODO: here UserId not comming from Get-Parameters -data $result.Parameters
            $params = Get-Parameters -data $result
            $params.UserId | Should -Match "412be9d1-1460-4061-8eed-cca203fcb215"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Set-MgUserManagerByRef -MockWith { $args } -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserManager"
            $result = Set-EntraUserManager -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -RefObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf"

            #  TODO: here UserId not comming from Get-Parameters -data $result.Parameters
            $params = Get-Parameters -data $result

            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }  

    }
}