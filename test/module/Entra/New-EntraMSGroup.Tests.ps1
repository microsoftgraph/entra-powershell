BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "DisplayName"         = "demosampletest"
              "Id"                  = "9a9ab239-269c-4d91-9935-9f2cb16074fb"
              "MailEnabled"         = $false
              "Description"         = "desc test"
              "MailNickname"        = "demoHelpDeskAdminGroup"
              "SecurityEnabled"     = $true
              "Visibility"          = "Private"
              "IsAssignableToRole"  = $true
              "GroupTypes"          = @{}
              "Parameters"          = $args
            } 
        )
    }
    Mock -CommandName New-MgGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraMSGroup" {
    Context "Test for New-EntraMSGroup" {
        It "Should return created Group" {
            $result = New-EntraMSGroup -DisplayName "demosampletest" -Description "desc test" -MailEnabled $False -MailNickname "demoHelpDeskAdminGroup" -SecurityEnabled $True -IsAssignableToRole $True -Visibility "Private"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "demosampletest"
            $result.Description | should -Be "desc test" 
            $result.MailEnabled | should -Be $false
            $result.MailNickname | should -Be "demoHelpDeskAdminGroup"
            $result.SecurityEnabled | should -Be $true
            $result.IsAssignableToRole | should -Be $true
            $result.Visibility | should -Be "Private"
            $result.GroupTypes | should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when parameters are empty" {
            { New-EntraMSGroup -DisplayName -Description -MailEnabled -SecurityEnabled -MailNickName -IsAssignableToRole -Visibility -GroupTypes } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when MailEnabled parameters are Invalid" {
            { New-EntraMSGroup -DisplayName "demosampletest" -Description "desc test" -MailEnabled "test"  } | Should -Throw "Cannot process argument transformation on parameter*"
        }

        It "Should fail when IsAssignableToRole parameters are Invalid" {
            { New-EntraMSGroup -DisplayName "demosampletest" -Description "desc test" -IsAssignableToRole "test"  } | Should -Throw "Cannot process argument transformation on parameter*"
        }

        It "Should fail when SecurityEnabled parameters are Invalid" {
            { New-EntraMSGroup -DisplayName "demosampletest" -Description "desc test" -SecurityEnabled 'test'  } | Should -Throw "Cannot process argument transformation*"
        }

        It "Should contain ObjectId in result" {
            $result = New-EntraMSGroup -DisplayName "demosampletest" -Description "desc test" -MailEnabled $False -MailNickname "demoHelpDeskAdminGroup" -SecurityEnabled $True -IsAssignableToRole $True -Visibility "Private"
            $result.ObjectId | should -Be "9a9ab239-269c-4d91-9935-9f2cb16074fb"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSGroup"
           
            $result = New-EntraMSGroup -DisplayName "demosampletest" -Description "desc test" -MailEnabled $False -MailNickname "demoHelpDeskAdminGroup" -SecurityEnabled $True -IsAssignableToRole $True -Visibility "Private"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   
    }
}