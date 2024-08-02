BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
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
    Mock -CommandName Get-MgGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraMSGroup" {
    Context "Test for Get-EntraMSGroup" {
        It "Get a specific group by using an ID" {
            $result = Get-EntraMSGroup -Id "ff586bcb-be06-466e-96ac-54f792ee3b52"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "Sales Team"
            $result.Description | should -BeNullOrEmpty
            $result.MailEnabled | should -Be $true
            $result.MailNickname | should -Be "SalesTeam"
            $result.SecurityEnabled | should -Be $false
            $result.IsAssignableToRole | should -BeNullOrEmpty
            $result.Visibility | should -BeNullOrEmpty
            $result.GroupTypes | should -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraMSGroup -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraMSGroup -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should return all groups" {
            $group = Get-EntraMSGroup -All $true
            $group | Should -Not -BeNullOrEmpty            

            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraMSGroup -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }  

        It "Should fail when All is invalid" {
            { Get-EntraMSGroup -All "" } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }     

        It "Should return top user membership" {
            $top = Get-EntraMSGroup -Top 5
            $top | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraMSGroup -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }

        It "Should fail when top is invalid" {
            { Get-EntraMSGroup -Top XYZ } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }    

        It "Should get a group by DisplayName" {
            $displayName = Get-EntraMSGroup -Filter "DisplayName eq 'Sales Team'"
            $displayName | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when Filter is empty" {
            { Get-EntraMSGroup -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }  

        It "Should Search among retrieved groups" {
            $searchString = Get-EntraMSGroup -SearchString "Sales Team"
            $searchString | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when SearchString is empty" {
            { Get-EntraMSGroup -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraMSGroup -Id "ff586bcb-be06-466e-96ac-54f792ee3b52"
            $result.ObjectId | should -Be "ff586bcb-be06-466e-96ac-54f792ee3b52"
        } 

        It "Should contain Filter in parameters when SearchString passed to it" {
            $result = Get-EntraMSGroup -SearchString "Sales Team"
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Contain "mailNickName eq 'Sales Team' or (mail eq 'Sales Team' or (displayName eq 'Sales Team' or startswith(displayName,'Sales Team')))"
        }

        It "Should contain GroupId in parameters when passed Id to it" {
            $result = Get-EntraMSGroup -Id "ff586bcb-be06-466e-96ac-54f792ee3b52"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "ff586bcb-be06-466e-96ac-54f792ee3b52"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSGroup"

            $result = Get-EntraMSGroup -Id "ff586bcb-be06-466e-96ac-54f792ee3b52"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Contain $userAgentHeaderValue
        }    
    }
}