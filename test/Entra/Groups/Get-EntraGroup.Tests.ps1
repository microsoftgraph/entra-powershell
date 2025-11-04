# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraGroup with parameters: $($args | ConvertTo-Json -Depth 3)"
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

    Mock -CommandName Get-MgGroup -MockWith $scriptblock -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("GroupMember.Read.All") } } -ModuleName Microsoft.Entra.Groups
}
  
Describe "Get-EntraGroup" {
    Context "Test for Get-EntraGroup" {
        It "Should return specific group" {
            $result = Get-EntraGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'aaaaaaaa-1111-2222-3333-cccccccccccc'

            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }       
        It "Should fail when GroupId is empty" {
            { Get-EntraGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }
        It "Should fail when searchstring is empty" {
            { Get-EntraGroup -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        } 
        It "Should fail when filter is empty" {
            { Get-EntraGroup -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should fail when Top is empty" {
            { Get-EntraGroup -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraGroup -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return all group" {
            $result = Get-EntraGroup -All
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraGroup -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }           
        It "Should return specific group by searchString" {
            $result = Get-EntraGroup -SearchString 'demo'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'demo'

            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        } 
        It "Should return specific group by filter" {
            $result = Get-EntraGroup -Filter "DisplayName -eq 'demo'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'demo'

            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }  
        It "Should return top group" {
            $result = Get-EntraGroup -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.ObjectId | should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        } 
        It "Should contain GroupId in parameters when passed GroupId to it" {
            $result = Get-EntraGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {
            $result = Get-EntraGroup -SearchString 'demo'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "demo"
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

            Mock -CommandName Get-MgGroup -MockWith $scriptblock -ModuleName Microsoft.Entra.Groups
            $result = Get-EntraGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property Id,DisplayName,MailEnabled
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

            Mock -CommandName Get-MgGroup -MockWith $scriptblock -ModuleName Microsoft.Entra.Groups
            $result = Get-EntraGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property IsSubscribedByMail,Id -AppendSelected
            $result.ObjectId | should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.IsSubscribedByMail | should -Be $false
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroup"
            $result = Get-EntraGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroup"
            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Get-EntraGroup -SearchString 'demo' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
        It "Should return groups with errors only when HasErrorsOnly is specified" {
            Mock -CommandName Get-MgGroup -MockWith $scriptblockWithErrors -ModuleName Microsoft.Entra.Groups
            $result = Get-EntraGroup -HasErrorsOnly
            $result | Should -Not -BeNullOrEmpty
            $result.ServiceProvisioningErrors | Should -Not -BeNullOrEmpty
            $result.ServiceProvisioningErrors.Count | Should -BeGreaterThan 0

            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should filter out groups without errors when HasErrorsOnly is specified" {
            $result = Get-EntraGroup -HasErrorsOnly
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should return groups with license errors only when HasLicenseErrorsOnly is specified" {
            $result = Get-EntraGroup -HasLicenseErrorsOnly
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "demo"

            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should add license error filter when HasLicenseErrorsOnly is specified" {
            $result = Get-EntraGroup -HasLicenseErrorsOnly
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "hasMembersWithLicenseErrors eq true"
        }
        It "Should combine filters when HasLicenseErrorsOnly is used with other filters" {
            $result = Get-EntraGroup -Filter "displayName eq 'test'" -HasLicenseErrorsOnly
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "displayName eq 'test'"
            $params.Filter | Should -Match "hasMembersWithLicenseErrors eq true"
        }
        It "Should work with SearchString and HasErrorsOnly together" {
            Mock -CommandName Get-MgGroup -MockWith $scriptblockWithErrors -ModuleName Microsoft.Entra.Groups
            $result = Get-EntraGroup -SearchString 'demo' -HasErrorsOnly
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'demo-error-group'
            $result.ServiceProvisioningErrors | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when HasErrorsOnly has an argument" {
            { Get-EntraGroup -HasErrorsOnly $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }
        It "Should fail when HasLicenseErrorsOnly has an argument" {
            { Get-EntraGroup -HasLicenseErrorsOnly $false } | Should -Throw "A positional parameter cannot be found that accepts argument 'False'."
        }   
    }
}

