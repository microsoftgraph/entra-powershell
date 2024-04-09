BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        #Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module .\test\module\Common-Functions.ps1 -Force
    
    $scriptblock = {
        #Write-Host "Mocking New-EntraGroup with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "DisplayName"      = "demo"
              "Id"               = "056b2531-005e-4f3e-be78-01a71ea30a04"
              "MailEnabled"      = "False"
              "Description"      = "test"
              "MailNickname"     = "demoNickname"
              "SecurityEnabled"  = "True"
            }
        )
    }
    
    Mock -CommandName New-MgGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraGroup" {
    Context "Test for New-EntraGroup" {
        It "Should return created Group" {
            $result = New-EntraGroup -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Description "test"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "demo"
            $result.MailEnabled | should -Be "False"
            $result.SecurityEnabled | should -Be "True"
            $result.Description | should -Be "test" 

            Should -Invoke -CommandName New-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when parameters are empty" {
            { New-EntraGroup -DisplayName "" -MailEnabled -SecurityEnabled -MailNickName "" -Description ""  } | Should -Throw "Missing an argument for parameter*"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraGroup"

            $result = New-EntraGroup -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   
    }
}