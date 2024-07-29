BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Tests for Update-EntraBetaSignedInUserPassword"{
    Context "Test for Update-EntraBetaSignedInUserPassword" {
        It "should updates the password for the signed-in user."{
            $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
            $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
            $result = Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when CurrentPassword is null" {
            {   $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Update-EntraBetaSignedInUserPassword -CurrentPassword  -NewPassword $NewPassword} | Should -Throw "Missing an argument for parameter 'CurrentPassword'*"
        }  

        It "Should fail when CurrentPassword is empty" {
            {   $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Update-EntraBetaSignedInUserPassword -CurrentPassword "" -NewPassword $NewPassword } | Should -Throw "Cannot process argument transformation on parameter 'CurrentPassword'*"
        }

        It "Should fail when NewPassword is null" {
            {   $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword } | Should -Throw "Missing an argument for parameter 'NewPassword'*"
        }  

        It "Should fail when NewPassword is empty" {
            {   $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword "" } | Should -Throw "Cannot process argument transformation on parameter 'NewPassword'*"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaSignedInUserPassword"
            $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
            $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
            $result = Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}