BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "DisplayName"                     = "My Test san"
              "Id"                              = "1a344543-ce01-4eee-a6bf-70ce848e08cb"
              "MailEnabled"                     = $false
              "Description"                     = ""
              "CreatedByAppId"                  = "8886ad7b-1795-4542-9808-c85859d97f23"
              "Mail"                            = ""
              "MailNickname"                    = "NotSet"
              "SecurityEnabled"                 = $true
              "Visibility"                      = ""
              "IsAssignableToRole"              = ""
              "GroupTypes"                      = @{}
              "ProxyAddresses"                  = @{} 
              "MembershipRule"                  = ""
              "MembershipRuleProcessingState"   = ""
              "Parameters"                      = $args
            } 
        )
    }
    Mock -CommandName New-MgBetaGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaGroup" {
    Context "Test for New-EntraBetaGroup" {
        It "Should return created Group" {
            $result = New-EntraBetaGroup -DisplayName "My Test san" -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "My Test san"
            $result.Description | should -BeNullOrEmpty 
            $result.MailEnabled | should -Be $false
            $result.MailNickname | should -Be "NotSet"
            $result.SecurityEnabled | should -Be $true
            $result.IsAssignableToRole | should -BeNullOrEmpty
            $result.Visibility | should -BeNullOrEmpty
            $result.GroupTypes | should -BeNullOrEmpty
            $result.Mail | should -BeNullOrEmpty
            $result.MembershipRule | should -BeNullOrEmpty
            $result.MembershipRuleProcessingState | should -BeNullOrEmpty
            $result.CreatedByAppId | should -Be "8886ad7b-1795-4542-9808-c85859d97f23"
            $result.Id | should -Be "1a344543-ce01-4eee-a6bf-70ce848e08cb"

            Should -Invoke -CommandName New-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when parameters are empty" {
            { New-EntraBetaGroup -DisplayName -Description -MailEnabled -SecurityEnabled -MailNickName -GroupTypes } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when MailEnabled parameters are Invalid" {
            { New-EntraBetaGroup -DisplayName "My Test san" -MailEnabled "test"  } | Should -Throw "Cannot process argument transformation on parameter*"
        }

        It "Should fail when SecurityEnabled parameters are Invalid" {
            { New-EntraBetaGroup -DisplayName "My Test san" -MailEnabled $false -SecurityEnabled 'test'  } | Should -Throw "Cannot process argument transformation*"
        }

        It "Should contain ObjectId in result" {
            $result = New-EntraBetaGroup -DisplayName "My Test san" -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet"
            $result.ObjectId | should -Be "1a344543-ce01-4eee-a6bf-70ce848e08cb"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaGroup"

            $result = New-EntraBetaGroup -DisplayName "My Test san" -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   
    }
}