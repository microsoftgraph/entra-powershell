BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                      = "May"
              "Description"             = "New AttributeSet"
              "MaxAttributesPerSet"     = 21
              "AdditionalProperties"    = @{"[@odata.context" = "https://graph.microsoft.com/beta/$metadata#directory/attributeSets/$entity"}
              "Parameters"              = $args
            }
        )
    }
    Mock -CommandName  New-MgBetaDirectoryAttributeSet -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaMSAttributeSet" {
    Context "Test for New-EntraBetaMSAttributeSet" {
        It "Should create new attribute set" {
            $result = New-EntraBetaMSAttributeSet -Id "May" -Description "New AttributeSet" -MaxAttributesPerSet 21
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'May'
            $result.Description | should -Be "New AttributeSet"
            $result.MaxAttributesPerSet | should -Be 21

            Should -Invoke -CommandName  New-MgBetaDirectoryAttributeSet -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { New-EntraBetaMSAttributeSet -Id  -Description "New AttributeSet" -MaxAttributesPerSet 21 } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Description is empty" {
            { New-EntraBetaMSAttributeSet -Id "May" -Description  -MaxAttributesPerSet 21 } | Should -Throw "Missing an argument for parameter 'Description'*"
        }

        It "Should fail when MaxAttributesPerSet is empty" {
            { New-EntraBetaMSAttributeSet -Id "May" -Description "New AttributeSet" -MaxAttributesPerSet  } | Should -Throw "Missing an argument for parameter 'MaxAttributesPerSet'*"
        }

        It "Should fail when MaxAttributesPerSet is invalid" {
            { New-EntraBetaMSAttributeSet -Id "May" -Description "New AttributeSet" -MaxAttributesPerSet "XYZ" } | Should -Throw "Cannot process argument transformation on parameter 'MaxAttributesPerSet'*"
        }

        It "Result should Contain ObjectId" {
            $result = New-EntraBetaMSAttributeSet -Id "May" -Description "New AttributeSet" -MaxAttributesPerSet 21
            $result.ObjectId | should -Be "May"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaMSAttributeSet"

            $result = New-EntraBetaMSAttributeSet -Id "May" -Description "New AttributeSet" -MaxAttributesPerSet 21
            $params = Get-Parameters -data $result.Parameters
            $params.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }    
    }
}