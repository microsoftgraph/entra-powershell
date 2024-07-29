BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "DisplayName"                     = "newtest2"
              "Id"                              = "9a9ab239-269c-4d91-9935-9f2cb16074fb"
              "MailEnabled"                     = $false
              "Description"                     = "desc test 2"
              "Mail"                            = ""
              "MailNickname"                    = "helpDeskAdminGroup"
              "SecurityEnabled"                 = $true
              "Visibility"                      = "Private"
              "IsAssignableToRole"              = $true
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

Describe "New-EntraBetaMSGroup" {
    Context "Test for New-EntraBetaMSGroup" {
        It "Should return created Group" {
            $result = New-EntraBetaMSGroup -DisplayName "newtest2" -Description "desc test 2" -MailEnabled $False -MailNickname "helpDeskAdminGroup" -SecurityEnabled $True -IsAssignableToRole $True -Visibility "Private"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "newtest2"
            $result.Description | should -Be "desc test 2" 
            $result.MailEnabled | should -Be $false
            $result.MailNickname | should -Be "helpDeskAdminGroup"
            $result.SecurityEnabled | should -Be $true
            $result.IsAssignableToRole | should -Be $true
            $result.Visibility | should -Be "Private"
            $result.GroupTypes | should -BeNullOrEmpty
            $result.Mail | should -BeNullOrEmpty
            $result.MembershipRule | should -BeNullOrEmpty
            $result.MembershipRuleProcessingState | should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when parameters are empty" {
            { New-EntraBetaMSGroup -DisplayName -Description -MailEnabled -SecurityEnabled -MailNickName -IsAssignableToRole -Visibility -GroupTypes } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when MailEnabled parameters are Invalid" {
            { New-EntraBetaMSGroup -DisplayName "newtest2" -Description "desc test 2" -MailEnabled "test"  } | Should -Throw "Cannot process argument transformation on parameter*"
        }

        It "Should fail when IsAssignableToRole parameters are Invalid" {
            { New-EntraBetaMSGroup -DisplayName "newtest2" -Description "desc test 2" -IsAssignableToRole "test"  } | Should -Throw "Cannot process argument transformation on parameter*"
        }

        It "Should fail when SecurityEnabled parameters are Invalid" {
            { New-EntraBetaMSGroup -DisplayName "newtest2" -Description "desc test 2" -SecurityEnabled 'test'  } | Should -Throw "Cannot process argument transformation*"
        }

        It "Should contain ObjectId in result" {
            $result = New-EntraBetaMSGroup -DisplayName "newtest2" -Description "desc test 2" -MailEnabled $False -MailNickname "helpDeskAdminGroup" -SecurityEnabled $True -IsAssignableToRole $True -Visibility "Private"
            $result.ObjectId | should -Be "9a9ab239-269c-4d91-9935-9f2cb16074fb"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaMSGroup"

            $result = New-EntraBetaMSGroup -DisplayName "newtest2" -Description "desc test 2" -MailEnabled $False -MailNickname "helpDeskAdminGroup" -SecurityEnabled $True -IsAssignableToRole $True -Visibility "Private"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   
    }
}