BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        #Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra
    }
    $scriptblock = {
        #Write-Host "Mocking Remove-MgApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @()
    } 
    Mock -CommandName Remove-MgApplication -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraApplication" {
    Context "Test for Remove-EntraApplication" {
        It "Should return empty object" {
            $result = Remove-EntraApplication -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraApplication -ObjectId "" }
        }   
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {
            $scriptblock = {
                param($args)
                return $args
            }     
            Mock -CommandName Remove-MgApplication -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraApplication -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $params = @{}
            for ($i = 0; $i -lt $result.Length; $i += 2) {
                $key = $result[$i] -replace '-', '' -replace ':', ''
                $value = $result[$i + 1]
                $params[$key] = $value
            }
            $params.ApplicationId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }   
    }
}