BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        #Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra
    }
    $scriptblock = {
        #Write-Host "Mocking Remove-EntraGroup with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @()
        }     
        Mock -CommandName Remove-MgGroup -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra
  }
  
  Describe "Remove-EntraGroup" {
    Context "Test for Remove-EntraGroup" {
        It "Should return empty object" {
            $result = Remove-EntraGroup -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraGroup -ObjectId "" }
        }      
    }
  }