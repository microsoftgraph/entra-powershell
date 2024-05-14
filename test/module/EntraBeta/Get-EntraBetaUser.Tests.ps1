BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null) {
        Import-Module Microsoft.Graph.Entra.Beta
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {

        return @(
            [PSCustomObject]@{
                Id                              = "fd560167-ff1f-471a-8d74-3b0070abcea1"
                ExternalUserState               = "PendingAcceptance"
                ExternalUserStateChangeDateTime = "16-01-2024 10:30:25"
                mobilePhone                     = "123456789"
                DeletedDateTime                 = $null
                AssignedLicenses                = $null
                AssignedPlans                   = $null
                PasswordProfile                 = $null
                DisplayName                     = "Conf Room Adams"
                Parameters                      = $args
            }
        )

    }

    Mock -CommandName Get-MgBetaUser -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaUser" {
    Context "Test for Get-EntraBetaUser" {
        It "Should return specific User" {
            $result = Get-EntraBetaUser -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"

            write-host ">>>>>>>>>>" $result

            # $result | Should -Not -BeNullOrEmpty
            # $result.Id | should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
            # $result.mobilePhone | Should -Be "123456789"
            # $result.ExternalUserStateChangeDateTime | Should -Be "16-01-2024 10:30:25"
            # $result.ExternalUserState | Should -Be "PendingAcceptance"
            # $result.DisplayName | Should -Be "Conf Room Adams"


            should -Invoke -CommandName Get-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        # It "Should fail when ObjectId is empty string value" {
        #     { Get-EntraBetaUser -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        # }

        # It "Should fail when ObjectId is empty" {
        #     { Get-EntraBetaUser -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'. Specify a parameter of type 'System.String' and try again."
        # }

        # It "Should return all contact" {
        #     $result = Get-EntraBetaUser -All $true
        #     $result | Should -Not -BeNullOrEmpty            
        #     Should -Invoke -CommandName Get-MgBetaUser  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        # }

        # It "Should fail when All is empty" {
        #     { Get-EntraBetaUser -All } | Should -Throw "Missing an argument for parameter 'All'*"
        # }

        # It "Should fail when All is invalid" {
        #     { Get-EntraContact -All XY } | Should -Throw  "Cannot process argument transformation on parameter 'All'*"
        # }  

        # It "Should return top user" {
        #     $result = Get-EntraBetaUser -Top 1
        #     $result | Should -Not -BeNullOrEmpty

        #     Should -Invoke -CommandName Get-MgBetaUser  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        # }    

        # It "Should fail when top is empty" {
        #     { Get-EntraBetaUser -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        # }  

        # It "Should fail when top is invalid" {
        #     { Get-EntraBetaUser -Top HH } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        # }  

        # It "Should return specific user by filter" {
        #     $result = Get-EntraBetaUser -Filter "DisplayName eq 'Conf Room Adams'"
        #     $result | Should -Not -BeNullOrEmpty
        #     $result.DisplayName | should -Be 'Conf Room Adams'

        #     Should -Invoke -CommandName Get-MgBetaUser  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        # } 

        # It "Should return specific user by search string" {
        #     $result = Get-EntraBetaUser -SearchString "Conf Room Adams"
        #     $result | Should -Not -BeNullOrEmpty
        #     $result.DisplayName | Should -Be 'Conf Room Adams'
        
        #     Should -Invoke -CommandName Get-MgBetaUser  -ModuleName Microsoft.Graph.Entra.Beta -Times 1

        # }

        # It "Should fail when search string is empty" {
        #     { Get-EntraBetaUser -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'.*"
        # }

        # It "Should fail when Missing an argument for parameter Filter" {
        #     { Get-EntraBetaUser -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        # } 

        # It "Should contain UserId in parameters when passed ObjectId to it" {
        #     $result = Get-EntraBetaUser -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
        #     $params = Get-Parameters -data $result.Parameters
        #     $params.UserId | Should -Match "fd560167-ff1f-471a-8d74-3b0070abcea1"
        # }

        # It "Should contain 'User-Agent' header" {
        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUser"
        #     $result = Get-EntraBetaUser -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
        #     $params = Get-Parameters -data $result.Parameters
        #     $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        # }  

    }
}