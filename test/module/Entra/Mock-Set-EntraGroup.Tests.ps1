BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    $scriptblock = {
        param($args)
        Write-Host "Mocking Set-EntraGroup with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @()
        }     
        Mock -CommandName Update-MgGroup -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra
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
    }
  }