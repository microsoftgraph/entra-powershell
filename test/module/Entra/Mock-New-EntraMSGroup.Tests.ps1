BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        #Write-Host "Mocking New-EntraMSGroup with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "DisplayName"      = "newtest2"
              "Id"               = "9a9ab239-269c-4d91-9935-9f2cb16074fb"
              "MailEnabled"      = "False"
              "Description"      = "desc test2"
              "MailNickname"     = "helpDeskAdminGroup"
              "SecurityEnabled"  = "True"
              "Visibility"       = "Private"
              "IsAssignableToRole" = "True"
              "Parameters"      = $args
            } 
        )
    }
    
    Mock -CommandName New-MgGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraMSGroup" {
    Context "Test for New-EntraMSGroup" {
        It "Should return created Group" {
            $result = New-EntraMSGroup -DisplayName "newtest2" -Description "desc test2" -MailEnabled $False -MailNickname "helpDeskAdminGroup" -SecurityEnabled $True -IsAssignableToRole $True -Visibility "Private"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "newtest2"
            $result.Description | should -Be "desc test2" 
            $result.MailEnabled | should -Be "False"
            $result.MailNickname | should -Be "helpDeskAdminGroup"
            $result.SecurityEnabled | should -Be "True"
            $result.IsAssignableToRole | should -Be "True" 
            $result.Visibility | should -Be "Private" 

           
            Should -Invoke -CommandName New-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when parameters are empty" {
            { New-EntraMSGroup -DisplayName "" -Description "" -MailEnabled -SecurityEnabled -MailNickName "" -IsAssignableToRole -Visibility ""  } | Should -Throw "Missing an argument for parameter*"
        }
        It "Should fail when MailEnabled parameters are Invalid" {
            { New-EntraMSGroup -DisplayName "newtest2" -Description "desc test2" -MailEnabled "test"  } | Should -Throw "Cannot process argument transformation on parameter*"
        }
        It "Should fail when IsAssignableToRole parameters are Invalid" {
            { New-EntraMSGroup -DisplayName "newtest2" -Description "desc test2" -IsAssignableToRole "test"  } | Should -Throw "Cannot process argument transformation on parameter*"
        }
        It "Should fail when SecurityEnabled parameters are Invalid" {
            { New-EntraMSGroup -DisplayName "newtest2" -Description "desc test2" -SecurityEnabled 'test'  } | Should -Throw "Cannot process argument transformation*"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSGroup"
            $result = New-EntraMSGroup -DisplayName "newtest2" -Description "desc test2" -MailEnabled $False -MailNickname "helpDeskAdminGroup" -SecurityEnabled $True -IsAssignableToRole $True -Visibility "Private"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   
    }
}