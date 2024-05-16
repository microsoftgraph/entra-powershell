BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        #    Write-Host "Mocking Get-MgBetaUser with parameters: $($args | ConvertTo-Json -Depth 3)"
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
        It "Should return specific user" {
            $result = Get-EntraBetaUser -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('fd560167-ff1f-471a-8d74-3b0070abcea1')
            Should -Invoke -CommandName Get-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaUser -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return all users" {
            $result = Get-EntraBetaUser -All $true
            $result | Should -Not -BeNullOrEmpty  
            Should -Invoke -CommandName Get-MgBetaUser  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraBetaUser -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }     
        It "Should fail when invalid parameter is passed" {
            { Get-EntraBetaUser -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }       
        It "Should return specific user by searchstring" {
            $result = Get-EntraBetaUser -SearchString 'Conf Room Adams'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Conf Room Adams'
            Should -Invoke -CommandName Get-MgBetaUser  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        } 
        It "Should return specific user by filter" {
            $result = Get-EntraBetaUser -Filter "DisplayName -eq 'Conf Room Adams'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Conf Room Adams'
            Should -Invoke -CommandName Get-MgBetaUser  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  
        It "Should return top user" {
            $result = Get-EntraBetaUser -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaUser  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaUser -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result.ObjectId | should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
        }     
        It "Should contain UserId in parameters when passed ObjectId to it" {              
            $result = Get-EntraBetaUser -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
        }
        It "Should contain Filter in parameters when passed Filter to it" {               
            $result = Get-EntraBetaUser -Filter 'Conf Room Adams'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Conf Room Adams"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUser"
            $result = Get-EntraBetaUser -SearchString 'Conf Room Adams'
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        It "Should support minimum set of parameter sets" {
            $GetAzureADUser = Get-Command Get-EntraBetaUser
            $GetAzureADUser.ParameterSets.Name | Should -BeIn @("GetQuery", "GetVague", "GetById")
            $GetAzureADUser.Visibility | Should -Be "Public"
            $GetAzureADUser.CommandType | Should -Be "Function"
        }
    
        It "Should return a list of users by default" {
            $GetAzureADUser = Get-Command Get-EntraBetaUser
            $GetAzureADUser.ModuleName | Should -Be "Microsoft.Graph.Entra.Beta"
            $GetAzureADUser.DefaultParameterSet | Should -Be "GetQuery"
        }    
        It 'Should have List parameterSet' {
            $GetAzureADUser = Get-Command Get-EntraBetaUser
            $ListParameterSet = $GetAzureADUser.ParameterSets | Where-Object Name -eq "GetQuery"
            $ListParameterSet.Parameters.Name | Should -Contain All
            $ListParameterSet.Parameters.Name | Should -Contain Filter
            $ListParameterSet.Parameters.Name | Should -Contain Top
        }    
        It 'Should have Get parameterSet' {
            $GetAzureADUser = Get-Command Get-EntraBetaUser
            $GetParameterSet = $GetAzureADUser.ParameterSets | Where-Object Name -eq "GetById"
            $GetParameterSet.Parameters.Name | Should -Contain ObjectId
        }    
        It 'Should have GetViaIdentity parameterSet' {
            $GetAzureADUser = Get-Command Get-EntraBetaUser
            $GetViaIdentityParameterSet = $GetAzureADUser.ParameterSets | Where-Object Name -eq "GetVague"
            $GetViaIdentityParameterSet.Parameters.Name | Should -Contain SearchString
            $GetViaIdentityParameterSet.Parameters.Name | Should -Contain All
        }
    }
}