# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DisplayName"     = "demo"
                "Id"              = "aaaaaaaa-1111-2222-3333-cccccccccccc"
                "MailEnabled"     = "False"
                "Description"     = "test"
                "MailNickname"    = "demoNickname"
                "SecurityEnabled" = "True"
                "Parameters"      = $args
                "ServiceProvisioningErrors" = @()
            }
        )
    }

    $scriptblockWithErrors = {
        return @(
            [PSCustomObject]@{
                "DisplayName"               = "demo-error-group"
                "Id"                        = "aaaaaaaa-1111-2222-3333-cccccccccccc"
                "MailEnabled"               = $false
                "Description"               = "test group with errors"
                "MailNickname"              = "demoErrorNickname"
                "SecurityEnabled"           = $true
                "ServiceProvisioningErrors" = @(
                    @{
                        "ErrorDetail" = @{
                            "Code"    = "DirectoryLimitExceeded"
                            "Message" = "Directory object quota limit exceeded"
                        }
                    }
                )
                "Parameters"                = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaGroup -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("GroupMember.Read.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}
  
Describe "Get-EntraBetaGroup" {
    Context "Test for Get-EntraBetaGroup" {
        It "Should return specific group" {
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'aaaaaaaa-1111-2222-3333-cccccccccccc'

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Get-EntraBetaGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }

        It "Should return all group" {
            $result = Get-EntraBetaGroup -All
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraBetaGroup -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }

        It "Should return specific group by searchstring" {
            $result = Get-EntraBetaGroup -SearchString 'demo'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'demo'

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        } 

        It "Should fail when SearchString is empty" {
            { Get-EntraBetaGroup -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }  

        It "Should return specific group by filter" {
            $result = Get-EntraBetaGroup -Filter "DisplayName -eq 'demo'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'demo'

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }  

        It "Should fail when Filter is empty" {
            { Get-EntraBetaGroup -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }  

        It "Should return top group" {
            $result = Get-EntraBetaGroup -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraBetaGroup -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraBetaGroup -Top y } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  
        
        It "Result should Contain GroupId" {
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.ObjectId | should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        } 

        It "Should contain GroupId in parameters when passed GroupId to it" {
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }

        It "Should contain Filter in parameters when passed SearchString to it" {
            $result = Get-EntraBetaGroup -SearchString 'demo'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "demo"
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'demo'

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'demo'

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should return specified properties" {
            $scriptblock = {
                return @(
                    [PSCustomObject]@{
                        "DisplayName"     = "demo"
                        "Id"              = "aaaaaaaa-1111-2222-3333-cccccccccccc"
                        "MailEnabled"     = $false
                    }
                )
            }

            Mock -CommandName Get-MgBetaGroup -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Groups
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property Id,DisplayName,MailEnabled
            $result.ObjectId | should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }
        It "Should return append specified properties to the default properties" {
            $scriptblock = {
                return @(
                    [PSCustomObject]@{
                        "DisplayName"        = "demo"
                        "Id"                 = "aaaaaaaa-1111-2222-3333-cccccccccccc"
                        "MailEnabled"        = $false
                        "CreatedDateTime"    = "2023-01-01T00:00:00Z"
                        "IsSubscribedByMail" = $false
                        "DeletedDateTime"    = $null
                        "GroupTypes"         = @("Unified")
                        "MailNickname"       = "demoNickname"
                        "SecurityEnabled"    = $true
                        "Visibility"         = "Public"
                        "Description"        = "test"
                    }
                )
            }

            Mock -CommandName Get-MgBetaGroup -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Groups
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property IsSubscribedByMail
            $result.ObjectId | should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.IsSubscribedByMail | should -Be $false
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaGroup"
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaGroup"
            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }    

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaGroup -SearchString 'demo' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

        It "Should return groups with errors only when HasErrorsOnly is specified" {
            Mock -CommandName Get-MgBetaGroup -MockWith $scriptblockWithErrors -ModuleName Microsoft.Entra.Beta.Groups
            $result = Get-EntraBetaGroup -HasErrorsOnly
            $result | Should -Not -BeNullOrEmpty
            $result.ServiceProvisioningErrors | Should -Not -BeNullOrEmpty
            $result.ServiceProvisioningErrors.Count | Should -BeGreaterThan 0

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should filter out groups without errors when HasErrorsOnly is specified" {
            $result = Get-EntraBetaGroup -HasErrorsOnly
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should return groups with license errors only when HasLicenseErrorsOnly is specified" {
            $result = Get-EntraBetaGroup -HasLicenseErrorsOnly
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "demo"

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should add license error filter when HasLicenseErrorsOnly is specified" {
            $result = Get-EntraBetaGroup -HasLicenseErrorsOnly
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "hasMembersWithLicenseErrors eq true"
        }
        It "Should combine filters when HasLicenseErrorsOnly is used with other filters" {
            $result = Get-EntraBetaGroup -Filter "displayName eq 'test'" -HasLicenseErrorsOnly
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "displayName eq 'test'"
            $params.Filter | Should -Match "hasMembersWithLicenseErrors eq true"
        }
        It "Should work with SearchString and HasErrorsOnly together" {
            Mock -CommandName Get-MgBetaGroup -MockWith $scriptblockWithErrors -ModuleName Microsoft.Entra.Beta.Groups
            $result = Get-EntraBetaGroup -SearchString 'demo' -HasErrorsOnly
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'demo-error-group'
            $result.ServiceProvisioningErrors | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when HasErrorsOnly has an argument" {
            { Get-EntraBetaGroup -HasErrorsOnly $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }
        It "Should fail when HasLicenseErrorsOnly has an argument" {
            { Get-EntraBetaGroup -HasLicenseErrorsOnly $false } | Should -Throw "A positional parameter cannot be found that accepts argument 'False'."
        }   
    }
}

