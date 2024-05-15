BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "3da073b9-e731-4ec1-a4f6-6e02865a8c8a"
              "DeletedDateTime"              = $null
              "AdditionalProperties"         = @{
                                                  "@odata.type"          = "#microsoft.graph.group"
                                                  "displayName"          = "Mock-Membership"
                                                  "description"          = "MockData"
                                                  "organizationId"       = "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
                                                  "createdByAppId"       = "1b730954-1685-4b74-9bfd-dac224a7b894"
                                                  "mailEnabled"          =  $False
                                                  "securityEnabled"      =  $True
                                                  "renewedDateTime"      = "2023-10-18T07:21:48Z"
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaUserMemberOf -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaUserMembership" {
Context "Test for Get-EntraBetaUserMembership" {
        It "Should return specific user membership" {
            $result = Get-EntraBetaUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "3da073b9-e731-4ec1-a4f6-6e02865a8c8a"
            $result.AdditionalProperties.DisplayName | Should -Be "Mock-Membership"
            $result.AdditionalProperties."@odata.type" | Should -Be "#microsoft.graph.group"

            Should -Invoke -CommandName Get-MgBetaUserMemberOf -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaUserMembership -ObjectId   } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraBetaUserMembership -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return all user memberships" {
            $result = Get-EntraBetaUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgBetaUserMemberOf -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraBetaUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }
         It "Should fail when All is invalid" {
            { Get-EntraBetaUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -All XY } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }
        It "Should return top 1 user memberships" {
            $result = Get-EntraBetaUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "3da073b9-e731-4ec1-a4f6-6e02865a8c8a"

            Should -Invoke -CommandName Get-MgBetaUserMemberOf -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraBetaUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result.ObjectId | should -Be "3da073b9-e731-4ec1-a4f6-6e02865a8c8a"
        }
        It "Should contain UserId in parameters when passed ObjectId to it" {    
            
            $result = Get-EntraBetaUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserMembership"

            $result = Get-EntraBetaUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}   