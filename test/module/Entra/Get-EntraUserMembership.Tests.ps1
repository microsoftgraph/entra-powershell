BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DeletedDateTime"       = ""
                "Id"                    = "3da073b9-e731-4ec1-a4f6-6e02865a8c8a"
                "AdditionalProperties"  = @{
                    '@odata.type'       = '#microsoft.graph.administrativeUnit'
                    'displayName'       = "NEW2"
                    'description'       = "TEST221"
                }
                "Parameters"            = $args
            }
        )
    }    
    Mock -CommandName Get-MgUserMemberOf -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraUserMembership" {
    Context "Test for Get-EntraUserMembership" {
        It "Should return specific user membership" {
            $result = Get-EntraUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result | Should -Not -BeNullOrEmpty
            

            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraUserMembership -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is invalid" {
            { Get-EntraUserMembership -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should return all user membership" {
            $result = Get-EntraUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }  
        
        It "Should fail when All is invalid" {
            { Get-EntraUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -All XY } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }     
        
        It "Should return top user membership" {
            $result = Get-EntraUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top 5
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result.ObjectId | should -Be "3da073b9-e731-4ec1-a4f6-6e02865a8c8a"
        } 

        It "Should contain UserId in parameters when passed ObjectId to it" {
            $result = Get-EntraUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserMembership"

            $result = Get-EntraUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Contain $userAgentHeaderValue
        }    
    }
}