BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraMSAttributeSet" {
    Context "Test for Set-EntraMSAttributeSet" {
        It "Should return created AttributeSet" {
            $result = Set-EntraMSAttributeSet -Id "NewCustomAttributeSet" -Description "CustomAttributeSet" -MaxAttributesPerSet 125 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id parameter is invalid" {
            { Set-EntraMSAttributeSet -Id } | Should -Throw "Missing an argument for parameter 'Id*"
        }
        It "Should fail when Description parameter is empty" {
            { Set-EntraMSAttributeSet -Description } | Should -Throw "Missing an argument for parameter 'Description*"
        }
        It "Should fail when MaxAttributesPerSet parameter is empty" {
            { Set-EntraMSAttributeSet -MaxAttributesPerSet } | Should -Throw "Missing an argument for parameter 'MaxAttributesPerSet*"
        }
        It "Should fail when MaxAttributesPerSet parameter is invalid" {
            { Set-EntraMSAttributeSet -MaxAttributesPerSet "a"} | Should -Throw "Cannot process argument transformation on parameter 'MaxAttributesPerSet'.*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSAttributeSet"

            Set-EntraMSAttributeSet -Id "NewCustomAttributeSet" -Description "CustomAttributeSet" -MaxAttributesPerSet 125 | Out-Null
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }   
    }
}