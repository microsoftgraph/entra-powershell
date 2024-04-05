BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        #Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra
    }
    $scriptblock = {
        # Write-Host "Mocking Update-MgApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @()
    }     
    Mock -CommandName Update-MgApplication -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraApplication"{
    Context "Test for Set-EntraApplication" {
        It "Should return empty object"{
            $result = Set-EntraApplication -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04 -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraApplication -ObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {
            $scriptblock = {
                param($args)
                return $args
            }     
            Mock -CommandName Update-MgApplication -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraApplication -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
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