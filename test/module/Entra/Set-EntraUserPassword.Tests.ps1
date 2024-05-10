BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgUser -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraUserPassword" {
    Context "Test for Set-EntraUserPassword" {
        It "Should return empty object" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           $result = Set-EntraUserPassword -ObjectId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
           $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { $result = Set-EntraUserPassword -ObjectId  -Password $secPassword } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { $result = Set-EntraUserPassword -ObjectId "" -Password $secPassword } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string*"
        }
        It "Should fail when Password is empty" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force 
           { $result = Set-EntraUserPassword -ObjectId $userUPN -Password  } | Should -Throw "Missing an argument for parameter 'Password'*"
        }
        It "Should fail when Password is invalid" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { $result = Set-EntraUserPassword -ObjectId $userUPN -Password "" } | Should -Throw "Cannot process argument transformation on parameter 'Password'*"
        }
        It "Should fail when ForceChangePasswordNextLogin  is empty" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { $result = Set-EntraUserPassword -ObjectId $userUPN -Password $secPassword -ForceChangePasswordNextLogin  } | Should -Throw "Missing an argument for parameter 'ForceChangePasswordNextLogin'*"
        }
        It "Should fail when ForceChangePasswordNextLogin is invalid" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { $result = Set-EntraUserPassword -ObjectId $userUPN -Password $secPassword -ForceChangePasswordNextLogin xyz } | Should -Throw "Cannot process argument transformation on parameter 'ForceChangePasswordNextLogin'*"
        }
        It "Should fail when EnforceChangePasswordPolicy is empty" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { $result = Set-EntraUserPassword -ObjectId $userUPN -Password $secPassword -EnforceChangePasswordPolicy  } | Should -Throw "Missing an argument for parameter 'EnforceChangePasswordPolicy'*"
        }
        It "Should fail when EnforceChangePasswordPolicy is invalid" {
           $userUPN="mock106@M365x99297270.OnMicrosoft.com"
           $newPassword="New@12345"
           $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
           { $result = Set-EntraUserPassword -ObjectId $userUPN -Password $secPassword -EnforceChangePasswordPolicy xyz } | Should -Throw "Cannot process argument transformation on parameter 'EnforceChangePasswordPolicy'*"
        }
         # Header is Missing in psm file   
        # It "Should contain 'User-Agent' header" {
        #     Mock -CommandName Update-MgUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra

        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserPassword"
        #     $userUPN="mock106@M365x99297270.OnMicrosoft.com"
        #     $newPassword="New@12345"
        #     $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
        #     $result = Set-EntraUserPassword -ObjectId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
        #     $params = Get-Parameters -data $result
        #     $para = $params | ConvertTo-json | ConvertFrom-Json
        #     write-host $para.PasswordProfile
        #     $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        # }

    }
}            