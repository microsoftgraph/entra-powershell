BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null) {
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    $Global:Matches = @('https://graph.microsoft.com/beta/$metadata#policies/homeRealmDiscoveryPolicies','https://graph.microsoft.com/beta/$metadata#policies/homeRealmDiscoveryPolicies')
    BeforeEach {
        $global:InvokeGraphRequestCounter = 0
    }
    $scriptblock = {
        $global:InvokeGraphRequestCounter++
        switch ($global:InvokeGraphRequestCounter) {
            1 {
                return @(
                    [PSCustomObject]@{
                        "@odata.context" = 'https://graph.microsoft.com/beta/$metadata#policies/homeRealmDiscoveryPolicies'
                    })
            }
            2 {
                return @()
                default {
                    return @()
                }
            }
        }
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaPolicy" {
    Context "Test for Remove-EntraBetaPolicy" {
        It "Should remove policy" {
            $result = Remove-EntraBetaPolicy -Id "834fbb5a-f6f9-4539-87e8-076583763504"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaPolicy"
            
            Remove-EntraBetaPolicy -Id "834fbb5a-f6f9-4539-87e8-076583763504"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' -eq $userAgentHeaderValue -and $global:InvokeGraphRequestCounter -eq 2
            }
        } 
        AfterEach {
            $global:InvokeGraphRequestCounter = 0
        }
    }
}