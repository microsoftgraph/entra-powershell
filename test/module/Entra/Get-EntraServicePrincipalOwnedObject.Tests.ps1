BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{              
              "Id"                           = "111cc9b5-fce9-485e-9566-c68debafac5f"
              "DeletedDateTime"              = $null
              "AdditionalProperties"         = @{
                                                    accountEnabled = $true;
                                                    appDisplayName = "ToGraph_443democc3c"
                                                    servicePrincipalType = "Application"
                                                }
              "Parameters"                  = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalOwnedObject -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraServicePrincipalOwnedObject" {
    Context "Test for Get-EntraServicePrincipalOwnedObject" {
        It "Should return specific Owned Object" {
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('111cc9b5-fce9-485e-9566-c68debafac5f')
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraServicePrincipalOwnedObject -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is null" {
            { Get-EntraServicePrincipalOwnedObject -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should return all Owned Objects" {
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "2d028fff-7e65-4340-80ca-89be16dae0b3" -All $true
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraServicePrincipalOwnedObject -ObjectId "2d028fff-7e65-4340-80ca-89be16dae0b3" -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }
        It "Should return top Owned Object" {
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "2d028fff-7e65-4340-80ca-89be16dae0b3" -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $result.ObjectId | should -Be "111cc9b5-fce9-485e-9566-c68debafac5f"
        }     
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {              
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $params = Get-Parameters -data $result.Parameters
            $params.ServicePrincipalId | Should -Be "2d028fff-7e65-4340-80ca-89be16dae0b3"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalOwnedObject"
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}