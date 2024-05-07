BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgServicePrincipalOwnerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraServicePrincipalOwner" {
    Context "Test for Remove-EntraServicePrincipalOwner" {
        It "Should return empty object" {
            $result = Remove-EntraServicePrincipalOwner -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -OwnerId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgServicePrincipalOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraServicePrincipalOwner -ObjectId  -OwnerId "fd560167-ff1f-471a-8d74-3b0070abcea1" }| Should -Throw "Missing an argument for parameter 'ObjectId'.*"                
        } 
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraServicePrincipalOwner -ObjectId "" -OwnerId "fd560167-ff1f-471a-8d74-3b0070abcea1"} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        }
        It "Should fail when OwnerId is empty" {
            { Remove-EntraServicePrincipalOwner -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -OwnerId } | Should -Throw "Missing an argument for parameter 'OwnerId'.*"
        }
        It "Should fail when OwnerId is invalid" {
            { Remove-EntraServicePrincipalOwner -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -OwnerId ""} | Should -Throw "Cannot bind argument to parameter 'OwnerId' because it is an empty string."
        }
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgServicePrincipalOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraServicePrincipalOwner -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -OwnerId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "0008861a-d455-4671-bd24-ce9b3bfce288"
        }
        It "Should contain DirectoryObjectId in parameters when passed OwnerId to it" {
            Mock -CommandName Remove-MgServicePrincipalOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraServicePrincipalOwner -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -OwnerId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgServicePrincipalOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipalOwner"

            $result = Remove-EntraServicePrincipalOwner -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -OwnerId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}