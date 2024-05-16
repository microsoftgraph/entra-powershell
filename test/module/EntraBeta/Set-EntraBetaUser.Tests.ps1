BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaUser -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaUser"{
    Context "Test for Set-EntraBetaUser" {
        It "Should return empty object"{
            $result = Set-EntraBetaUser -ObjectId '056b2531-005e-4f3e-be78-01a71ea30a04' -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty 
            Should -Invoke -CommandName Update-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraBetaUser -ObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when invalid parameter is passed" {
            { Set-EntraBetaUser -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }
        It "Should contain UserId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaUser -ObjectId '056b2531-005e-4f3e-be78-01a71ea30a04'
            $params = Get-Parameters -data $result
            $params.UserId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUser"
            $result = Set-EntraBetaUser -ObjectId '056b2531-005e-4f3e-be78-01a71ea30a04'
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

        It "Should contain ExternalUserState, OnPremisesImmutableId, ExternalUserStateChangeDateTime, BusinessPhones, " {
            Mock -CommandName Update-MgBetaUser -MockWith { $args } -ModuleName Microsoft.Graph.Entra.Beta

            # format like "yyyy-MM-dd HH:mm:ss"
            $userStateChangedOn = [System.DateTime]::Parse("2015-12-08 15:15:19")

            $result = Set-EntraBetaUser -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04" `
                -UserState "PendingAcceptance" `
                -UserStateChangedOn  $userStateChangedOn `
                -ImmutableId "djkjsajsa-e32j2-2i32" `
                -Mobile "123111221" `
                -TelephoneNumber "1234567890"

            $params = Get-Parameters -data $result

            $params.BusinessPhones[0] | Should -Be "1234567890"

            $params.MobilePhone | Should -Be "123111221"

            $params.ExternalUserState | Should -Be "PendingAcceptance"

            $params.OnPremisesImmutableId | Should -Be "djkjsajsa-e32j2-2i32"

            $params.ExternalUserStateChangeDateTime | Should -Be $userStateChangedOn
        }
    }
}