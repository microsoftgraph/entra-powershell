BeforeAll {
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                              = "69641f6c-41dc-4f63-9c21-cc9c8ed12931"
             " DeletedDateTime"                 = $null
              "AdditionalProperties"            = @{"@odata.type" ="#microsoft.graph.group"
                                                    "DisplayName"                     = "All Employees"
                                                    "MailNickname"                    = "Employees"
                                                    "Mail"                            = "Employees@M365x99297270.OnMicrosoft.com"
                                                    "onPremisesProvisioningErrors"    = @{}
                                                    "ProxyAddresses"                  = @{SMTP="Employees@M365x99297270.OnMicrosoft.com"}
                                                    "SecurityEnabled"                 = "False"
                                                }
              "Parameters"                      = $args
            }
        )
        
    }  

    Mock -CommandName Get-MgContactMemberOf -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraContactMembership" {
    Context "Test for Get-EntraContactMembership" {
        It "Should return specific Contact Membership" {
            $result = Get-EntraContactMembership -ObjectId "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be '69641f6c-41dc-4f63-9c21-cc9c8ed12931'
            $result.DeletedDateTime | Should -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgContactMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }
        
        It "Should fail when ObjectId is empty" {
            { Get-EntraContactMembership -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is invalid" {
            { Get-EntraContactMembership -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should return all Contact Membership" {
            $result = Get-EntraContactMembership -ObjectId "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c" -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgContactMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraContactMembership -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }           
        
        It "Should fail when All is invalid" {
            { Get-EntraContactMembership -All GH } | Should -Throw  "Cannot process argument transformation on parameter 'All'*"
        }      

        It "Should return top Contact Membership" {
            $result = Get-EntraContactMembership -ObjectId "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgContactMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraContactMembership -ObjectId "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraContactMembership -ObjectId "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c" -Top DF } | Should -Throw  "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraContactMembership -ObjectId "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
            $result.ObjectId | should -Be "69641f6c-41dc-4f63-9c21-cc9c8ed12931"
        } 

        It "Should contain OrgContactId in parameters when passed ObjectId to it" {
            $result = Get-EntraContactMembership -ObjectId "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
            $params = Get-Parameters -data $result.Parameters
            $params.OrgContactId | Should -Match "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraContactMembership"
            
            $result = Get-EntraContactMembership -ObjectId "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
            Write-Host $params
        }    
    }
}