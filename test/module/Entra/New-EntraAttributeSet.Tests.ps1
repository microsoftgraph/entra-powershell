BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Description"     = "CustomAttributeSet"
                "Id"              = "NewCustomAttributeSet"
                "MaxAttributesPerSet"     = 125
                "@odata.context" = 'https://graph.microsoft.com/v1.0/$metadata#directory/attributeSets/$entity'
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraAttributeSet" {
    Context "Test for New-EntraAttributeSet" {
        It "Should return created AttributeSet" {
            $result = New-EntraAttributeSet -Id "NewCustomAttributeSet" -Description "CustomAttributeSet" -MaxAttributesPerSet 125 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "NewCustomAttributeSet"
            $result.MaxAttributesPerSet | should -Be 125
            $result.Description | should -Be "CustomAttributeSet" 

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id parameter is invalid" {
            { New-EntraAttributeSet -Id } | Should -Throw "Missing an argument for parameter 'Id*"
        }
        It "Should fail when Description parameter is empty" {
            { New-EntraAttributeSet -Description } | Should -Throw "Missing an argument for parameter 'Description*"
        }
        It "Should fail when MaxAttributesPerSet parameter is empty" {
            { New-EntraAttributeSet -MaxAttributesPerSet } | Should -Throw "Missing an argument for parameter 'MaxAttributesPerSet*"
        }
        It "Should fail when MaxAttributesPerSet parameter is invalid" {
            { New-EntraAttributeSet -MaxAttributesPerSet "a"} | Should -Throw "Cannot process argument transformation on parameter 'MaxAttributesPerSet'.*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraAttributeSet"

            New-EntraAttributeSet -Id "NewCustomAttributeSet" -Description "CustomAttributeSet" -MaxAttributesPerSet 125 | Out-Null
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }   
    }
}