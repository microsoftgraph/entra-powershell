BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $mockResponse = {
        return @{
            value = @(
                @{
                    Id                            = "e3108c4d-86ff-4ceb-9429-24e85b4b8cea"          
                    ageGroup                      = $null
                    onPremisesLastSyncDateTime    = $null
                    creationType                  = $null
                    imAddresses                   = {"adelev@m365x99297270.onmicrosoft.com"}
                    preferredLanguage             = $null
                    mail                          = "AdeleV@M365x99297270.OnMicrosoft.com"
                    securityIdentifier            = "S-1-12-1-1093396945-1080104032-2731339150-364051459"
                    identities                    = {}
                    consentProvidedForMinor       = $null
                    onPremisesUserPrincipalName   = $null
                    Parameters                    = $args
                }
            )
        }
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $mockResponse -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraApplicationOwner"{
    Context "Test for Get-EntraApplicationOwner"{
        It "Should return application owner" {
            $result = Get-EntraApplicationOwner -ObjectId "e3108c4d-86ff-4ceb-9429-24e85b4b8cea"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('e3108c4d-86ff-4ceb-9429-24e85b4b8cea')

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraApplicationOwner -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationOwner"
            $result = Get-EntraApplicationOwner -ObjectId "e3108c4d-86ff-4ceb-9429-24e85b4b8cea"
            $params = Get-Parameters -data $result.Parameters
            $a= $params | ConvertTo-json | ConvertFrom-Json
            $a.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }
    }
}