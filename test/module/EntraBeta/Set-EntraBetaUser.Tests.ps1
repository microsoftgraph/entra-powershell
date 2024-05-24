BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaUser -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaUser" {
    Context "Test for Set-EntraBetaUser" {
        It "Should update a user" {
            $user = Get-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee"
            $user.DisplayName = 'dummy1' 
            $result = Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Displayname $user.Displayname
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Set-EntraBetaUser -ObjectId   } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        } 

        It "Should fail when Id is invalid" {
            { Set-EntraBetaUser -ObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        } 

        It "Should fail when DisplayName is empty" {
            { Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Displayname  } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        } 

        It "Should fail when CreationType is empty" {
            { Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -CreationType  } | Should -Throw "Missing an argument for parameter 'CreationType'.*"
        } 

        It "Should fail when MailNickname is empty" {
            { Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -MailNickname  } | Should -Throw "Missing an argument for parameter*"
        } 
       
        It "Should fail when PasswordProfile is empty" {
            { Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -PasswordProfile  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when PasswordProfile is invalid" {
            { Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -PasswordProfile "" } | Should -Throw "Cannot process argument transformation on parameter 'PasswordProfile'.*"
        } 

        It "Should fail when City is empty" {
            { Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -City  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when Country is empty" {
            { Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Country  } | Should -Throw "Missing an argument for parameter*"
        } 

        # It "Should contain Identities in parameters when passed SignInNames to it" {
        #     Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

        #     $user = Get-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee"
        #     $user.DisplayName = 'dummy1' 
        #     $result = Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Displayname $user.Displayname -SignInNames "@(dummy10@M365x99297270.OnMicrosoft.com)"
        #     $params = Get-Parameters -data $result
        #     $params.Identities | Should -Be @("dummy10@M365x99297270.OnMicrosoft.com")
        # }        

        It "Should contain ExternalUserState in parameters when passed UserState to it" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $user = Get-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee"
            $user.DisplayName = 'dummy1' 
            $result = Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Displayname $user.Displayname -UserState ""
            $params = Get-Parameters -data $result
            $params.ExternalUserState | Should -BeNullOrEmpty
        }        
        
        It "Should contain OnPremisesImmutableId in parameters when passed ImmutableId to it" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $user = Get-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee"
            $user.DisplayName = 'dummy1' 
            $result = Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Displayname $user.Displayname -ImmutableId ""
            $params = Get-Parameters -data $result
            $params.OnPremisesImmutableId | Should -BeNullOrEmpty
        }        

        It "Should contain BusinessPhones in parameters when passed TelephoneNumber to it" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $user = Get-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee"
            $user.DisplayName = 'dummy1' 
            $result = Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Displayname $user.Displayname -TelephoneNumber ""
            $params = Get-Parameters -data $result
            $params.BusinessPhones | Should -BeNullOrEmpty
        }        

        It "Should contain ExternalUserStateChangeDateTime in parameters when passed UserStateChangedOn to it" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $user = Get-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee"
            $user.DisplayName = 'dummy1' 
            $result = Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Displayname $user.Displayname -UserStateChangedOn ""
            $params = Get-Parameters -data $result
            $params.ExternalUserStateChangeDateTime | Should -BeNullOrEmpty
        }        
        
        It "Should contain UserId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $user = Get-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee"
            $user.DisplayName = 'dummy1' 
            $result = Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Displayname $user.Displayname
            $params = Get-Parameters -data $result
            $params.UserId | Should -Be "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee"
        }        

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUser"
            $user = Get-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee"
            $user.DisplayName = 'dummy1' 
            $result = Set-EntraBetaUser -ObjectId "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Displayname $user.Displayname
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}