BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Value"         = $true
                "Parameters"    = $args
            }
        )
    }  
    Mock -CommandName Remove-MgGroupFromLifecyclePolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraMSLifecyclePolicyGroup" {
    Context "Test for Remove-EntraMSLifecyclePolicyGroup" {
        It "Should return empty Id" {
            $result = Remove-EntraMSLifecyclePolicyGroup  -Id "c9a455d8-982e-4c06-86d8-8dab15f03295" -GroupId "bea81df1-91cb-4b6e-aa79-b40888fe0b8b"
            $result.Value | Should -Be $true

            Should -Invoke -CommandName Remove-MgGroupFromLifecyclePolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraMSLifecyclePolicyGroup -Id -GroupId } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraMSLifecyclePolicyGroup -Id "" -GroupId "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should contain GroupLifecyclePolicyId in parameters when passed Id to it" {
            $result = Remove-EntraMSLifecyclePolicyGroup -Id "c9a455d8-982e-4c06-86d8-8dab15f03295" -GroupId "bea81df1-91cb-4b6e-aa79-b40888fe0b8b"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupLifecyclePolicyId | Should -Be "c9a455d8-982e-4c06-86d8-8dab15f03295"
        }

        It "Should contain GroupId in parameters when passed GroupId to it" {
            $result = Remove-EntraMSLifecyclePolicyGroup -Id "c9a455d8-982e-4c06-86d8-8dab15f03295" -GroupId "bea81df1-91cb-4b6e-aa79-b40888fe0b8b"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "bea81df1-91cb-4b6e-aa79-b40888fe0b8b"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSLifecyclePolicyGroup"

            $result = Remove-EntraMSLifecyclePolicyGroup -Id "c9a455d8-982e-4c06-86d8-8dab15f03295" -GroupId "bea81df1-91cb-4b6e-aa79-b40888fe0b8b"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}