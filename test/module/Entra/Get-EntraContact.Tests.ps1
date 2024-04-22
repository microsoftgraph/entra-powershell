BeforeAll {
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        Write-Host "Mocking Get-MgContact with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "DeletedDateTime"                 = $null
              "Id"                              = "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
              "Department"                      = $null
              "GivenName"                       = $null
              "DisplayName"                     = "Bob Kelly (TAILSPIN)"
              "JobTitle"                        = $null
              "OnPremisesLastSyncDateTime"      = $null
              "MailNickname"                    = "BobKTAILSPIN"
              "Mail"                            = "bobk@tailspintoys.com"
              "Phones"                          = $null
              "ServiceProvisioningErrors"       = @{}
              "ProxyAddresses"                  = @{"SMTP"="bobk@tailspintoys.com"}
              "Surname"                         = $null
              "Addresses"                       = @{    "City"= ""
                                                        "CountryOrRegion" = ""
                                                        "OfficeLocation"= ""
                                                        "PostalCode"= ""
                                                        "State"= ""
                                                        "Street"= ""
                                                }
              "AdditionalProperties"            = @{
                                                    imAddresses = ""
                                                    "@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#contacts/$entity"
                                                }
              "Manager"                         = $null
              "OnPremisesSyncEnabled"           = @{}
              "Parameters"                      = $args
            }
        )
        
    }  

    Mock -CommandName Get-MgContact -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraContact" {
    Context "Test for Get-EntraContact" {
        It "Should return specific Contact" {
            $result = Get-EntraContact -ObjectId "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be 'cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c'
            $result.OnPremisesSyncEnabled | Should -BeNullOrEmpty
            $result.OnPremisesLastSyncDateTime | Should -BeNullOrEmpty
            $result.Phones | Should -BeNullOrEmpty
            $result.ServiceProvisioningErrors | Should -BeNullOrEmpty
            $result.Mobile | Should -BeNullOrEmpty
            $result.TelephoneNumber | Should -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgContact -ModuleName Microsoft.Graph.Entra -Times 1
        }
        
        It "Should fail when ObjectId is empty" {
            { Get-EntraContact -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should return all contact" {
            $result = Get-EntraContact -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgContact  -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraContact -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }           
        
        It "Should return specific group by filter" {
            $result = Get-EntraContact -Filter "DisplayName -eq 'Bob Kelly (TAILSPIN)'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Bob Kelly (TAILSPIN)'

            Should -Invoke -CommandName Get-MgContact  -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when filter is empty" {
            { Get-EntraContact -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }           

        It "Should return top contact" {
            $result = Get-EntraContact -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgContact  -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when top is empty" {
            {Get-EntraContact -Top} | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraContact -ObjectId "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
            $result.ObjectId | should -Be "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
        } 

        It "Should contain OrgContactId in parameters when passed Name to it" {
            $result = Get-EntraContact -ObjectId "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
            $params = Get-Parameters -data $result.Parameters
            $params.OrgContactId | Should -Match "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraContact"

            $result = Get-EntraContact -ObjectId "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }    
    }
}