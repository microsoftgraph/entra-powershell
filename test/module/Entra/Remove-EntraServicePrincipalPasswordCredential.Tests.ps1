BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgServicePrincipalPassword -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraServicePrincipalPasswordCredential" {
    Context "Test for Remove-EntraServicePrincipalPasswordCredential" {
        It "Should return empty object" {
            $result = Remove-EntraServicePrincipalPasswordCredential -ObjectID "1a3d700a-bedb-4e8f-bdda-72979a952a8d" -KeyId "d1abd143-6d5f-4a82-8e4a-53d690c3eeb6"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgServicePrincipalPassword -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectID is empty" {
            { Remove-EntraServicePrincipalPasswordCredential -ObjectID  -KeyId "d1abd143-6d5f-4a82-8e4a-53d690c3eeb6" } | should -Throw "Missing an argument for parameter 'ObjectID'.*"
        }   
        It "Should fail when ObjectID is invalid" {
            {Remove-EntraServicePrincipalPasswordCredential -ObjectID "" -KeyId "d1abd143-6d5f-4a82-8e4a-53d690c3eeb6" } | should -Throw "Cannot bind argument to parameter 'ObjectID'*"
        }  
        It "Should fail when KeyId is empty" {
            {Remove-EntraServicePrincipalPasswordCredential -ObjectID "1a3d700a-bedb-4e8f-bdda-72979a952a8d" -KeyId   } | should -Throw "Missing an argument for parameter 'KeyId'.*"
        }   
        It "Should fail when KeyId is invalid" {
            { Remove-EntraServicePrincipalPasswordCredential -ObjectID "1a3d700a-bedb-4e8f-bdda-72979a952a8d" -KeyId ""} | should -Throw "Cannot bind argument to parameter 'KeyId'*"
        }  
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgServicePrincipalPassword -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraServicePrincipalPasswordCredential -ObjectID "1a3d700a-bedb-4e8f-bdda-72979a952a8d" -KeyId "d1abd143-6d5f-4a82-8e4a-53d690c3eeb6"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "1a3d700a-bedb-4e8f-bdda-72979a952a8d"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgServicePrincipalPassword -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipalPasswordCredential"
            $result =  Remove-EntraServicePrincipalPasswordCredential -ObjectID "1a3d700a-bedb-4e8f-bdda-72979a952a8d" -KeyId "d1abd143-6d5f-4a82-8e4a-53d690c3eeb6"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}