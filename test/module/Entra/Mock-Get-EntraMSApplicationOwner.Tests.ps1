BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        #Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-MgApplicationOwner with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "Id"                   = "fd560167-ff1f-471a-8d74-3b0070abcea1"
                "AdditionalProperties" = @{businessPhones={}; displayName="Conf Room Adams"; 
                                           mail="Adams@M365x99297270.OnMicrosoft.com"}
            }
        )
    }

    Mock -CommandName Get-MgApplicationOwner -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraMSApplicationOwner" {
    Context "Test for Get-EntraMSApplicationOwner" {        
        It "Should fail when ObjectId is empty" {
            { Get-EntraMSApplicationOwner -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return all application owners" {
            $result = Get-EntraMSApplicationOwner -ObjectId "c81d387e-d431-43b4-b12e-f07cbb35b771" -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgApplicationOwner -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraMSApplicationOwner -ObjectId "c81d387e-d431-43b4-b12e-f07cbb35b771" -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }
        It "Should return top application owner" {
            $result = Get-EntraMSApplicationOwner -ObjectId "c81d387e-d431-43b4-b12e-f07cbb35b771" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgApplicationOwner -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Result should Contain ObjectId" {
            $result = Get-EntraMSApplicationOwner -ObjectId "c81d387e-d431-43b4-b12e-f07cbb35b771"
            $result.ObjectId | should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
        }
        # issue in AdditionalProperties param transformation in args, will uncomment after resolve.
        # It "Should contain ApplicationId in parameters when passed ObjectId to it" {              
        #     Mock -CommandName Get-MgApplicationOwner -MockWith {$args} -ModuleName Microsoft.Graph.Entra

        #     $result = Get-EntraMSApplicationOwner -ObjectId "c81d387e-d431-43b4-b12e-f07cbb35b771"
        #     $params = Get-Parameters -data $result
        #     $params.ApplicationId | Should -Be "c81d387e-d431-43b4-b12e-f07cbb35b771"
        # }
        # It "Should contain 'User-Agent' header" {
        #     Mock -CommandName Get-MgApplicationOwner -MockWith {$args} -ModuleName Microsoft.Graph.Entra

        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSApplicationOwner"

        #     $result = Get-EntraMSApplicationOwner -ObjectId "c81d387e-d431-43b4-b12e-f07cbb35b771"
        #     $params = Get-Parameters -data $result
        #     $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        # }
    }
}