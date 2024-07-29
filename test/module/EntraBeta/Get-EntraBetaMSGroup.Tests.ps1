BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DisplayName"                       = "Sales Team"
                "Id"                                = "ff586bcb-be06-466e-96ac-54f792ee3b52"
                "MailEnabled"                       = $true
                "Description"                       = ""
                "MailNickname"                      = "SalesTeam"
                "SecurityEnabled"                   = $false
                "Visibility"                        = ""
                "IsAssignableToRole"                = ""
                "GroupTypes"                        = @{}
                "AdditionalProperties"              = @{
                    '@odata.context'                = "https://graph.microsoft.com/v1.0/$metadata#groups/$entity"
                    'creationOptions'               = @{}
                    'resourceBehaviorOptions'       = @{}
                    'resourceProvisioningOptions'   = @{}
                }
                "Parameters"            = $args
                }
            )

        }
    Mock -CommandName  Get-MgBetaGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaMSGroup" {
    Context "Test for Get-EntraBetaMSGroup" {
        It "Get a specific group by using an ID" {
            $result = Get-EntraBetaMSGroup -Id "ff586bcb-be06-466e-96ac-54f792ee3b52"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "Sales Team"
            $result.Description | should -BeNullOrEmpty
            $result.MailEnabled | should -Be $true
            $result.MailNickname | should -Be "SalesTeam"
            $result.SecurityEnabled | should -Be $false
            $result.IsAssignableToRole | should -BeNullOrEmpty
            $result.Visibility | should -BeNullOrEmpty
            $result.GroupTypes | should -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraBetaMSGroup -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaMSGroup -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should return all groups" {
            $group = Get-EntraBetaMSGroup -All $true
            $group | Should -Not -BeNullOrEmpty            

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraBetaMSGroup -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }  

        It "Should fail when All is invalid" {
            { Get-EntraBetaMSGroup -All "" } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }     

        It "Should return top user membership" {
            $top = Get-EntraBetaMSGroup -Top 5
            $top | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraBetaMSGroup -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should get a group by DisplayName" {
            $displayName = Get-EntraBetaMSGroup -Filter "DisplayName eq 'Sales Team'"
            $displayName | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when Filter is empty" {
            { Get-EntraBetaMSGroup -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }  

        It "Should Search among retrieved groups" {
            $searchString = Get-EntraBetaMSGroup -SearchString "Sales Team"
            $searchString | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when SearchString is empty" {
            { Get-EntraBetaMSGroup -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }  

        It "Result should get DisplayName property values for all groups" {
            $result = Get-EntraBetaMSGroup -Select "DisplayName"
            $result.DisplayName | should -Contain "Sales Team"
        } 
        
        It "Result should get DisplayName property values for a group" {
            $result = Get-EntraBetaMSGroup -Id "ff586bcb-be06-466e-96ac-54f792ee3b52" -Select "DisplayName"
            $result.DisplayName | should -Be "Sales Team"
        } 

        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaMSGroup -Id "ff586bcb-be06-466e-96ac-54f792ee3b52"
            $result.ObjectId | should -Be "ff586bcb-be06-466e-96ac-54f792ee3b52"
        } 

        It "Should contain Filter in parameters when SearchString passed to it" {
            $result = Get-EntraBetaMSGroup -SearchString "Sales Team"
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Contain "mailNickName eq 'Sales Team' or (mail eq 'Sales Team' or (displayName eq 'Sales Team' or startswith(displayName,'Sales Team')))"
        }

        It "Should contain GroupId in parameters when passed Id to it" {
            $result = Get-EntraBetaMSGroup -Id "ff586bcb-be06-466e-96ac-54f792ee3b52"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "ff586bcb-be06-466e-96ac-54f792ee3b52"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaMSGroup"

            $result = Get-EntraBetaMSGroup -Id "ff586bcb-be06-466e-96ac-54f792ee3b52"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Contain $userAgentHeaderValue
        }    
    }
}