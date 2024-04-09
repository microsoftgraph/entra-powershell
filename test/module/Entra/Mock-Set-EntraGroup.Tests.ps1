BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        #Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module .\test\module\Common-Functions.ps1 -Force

    Mock -CommandName Update-MgGroup -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraGroup" {
    Context "Test for Set-EntraGroup" {
        It "Should return empty object" {
            $result = Set-EntraGroup -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04 -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Description "test"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraGroup -ObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        } 
        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraGroup -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }        
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraGroup"

            $result = Set-EntraGroup -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}