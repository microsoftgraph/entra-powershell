# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------



Describe "Set-EntraBetaAppRoleToApplicationUser" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Governance) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Governance
        }

        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        Mock -CommandName Get-EntraContext -MockWith {
            @{
                Environment = @{
                    Name = "Global"
                }
                Scopes = @('Application.ReadWrite.All','Application.ReadWrite.OwnedBy','User.ReadWrite.All','AppRoleAssignment.ReadWrite.All')
            }
        } -ModuleName Microsoft.Entra.Beta.Governance

        $appName = "UnitTestApp"
        $applicationId = "app1"
        $appAppId = "00000000-0000-0000-0000-000000000001"
        $spId = "sp1"
        $roleName = "reader"

        $csvPath = Join-Path $TestDrive "users.csv"
        @"
userPrincipalName,displayName,mailNickname,role,memberType
user1@contoso.com,User One,userone,$roleName,User
"@ | Set-Content -Path $csvPath -Encoding UTF8

    }

    Context "Parameter validation and connection checks" {
        It "Should fail when not connected (Get-EntraContext returns null) and not call Graph" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Governance
            Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Governance

            # Act/Assert
            { Set-EntraBetaAppRoleToApplicationUser -DataSource Generic -FilePath $csvPath -ApplicationName "UnitTestApp" } |
                Should -Throw "Not connected to Microsoft Graph*"

            # Ensure no Graph calls occurred
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -Times 0
        }

        It "Should fail when DataSource is missing" {
            { Set-EntraBetaAppRoleToApplicationUser -FilePath $csvPath -ApplicationName "UnitTestApp" } |
                Should -Throw "Cannot process command because of one or more missing mandatory parameters: DataSource*"
        }

        It "Should fail when FilePath is invalid" {
           { Set-EntraBetaAppRoleToApplicationUser -DataSource Generic -FilePath (Join-Path $TestDrive "doesnotexist.csv") -ApplicationName "UnitTestApp" } |
                Should -Throw "Cannot validate argument on parameter 'FilePath'*"
        }

        It "Should fail when ApplicationName is empty" {
            { Set-EntraBetaAppRoleToApplicationUser -DataSource Generic -FilePath $csvPath -ApplicationName "" } |
                Should -Throw "Cannot validate argument on parameter 'ApplicationName'*"
        }
    }

    Context "Happy path: creates user, app + SP, role, and assignment" {
        It "Should process one user and return a single assignment object" {
            # users GET: not found
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -like '/beta/users*' -and $Method -eq 'GET' } -MockWith { @{ value = @() } }
            # users POST: create
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -like '/beta/users*' -and $Method -eq 'POST' } -MockWith { @{ Id = 'u1'; UserPrincipalName = 'user1@contoso.com'; DisplayName = 'User One'; MailNickname = 'userone'; Mail = 'user1@contoso.com' } }

            # applications GET: not found
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -like '/beta/applications?*' -and $Method -eq 'GET' } -MockWith { @{ value = @() } }
            # applications POST: create app
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq '/beta/applications' -and $Method -eq 'POST' } -MockWith { @{ Id = $applicationId; AppId = $appAppId; DisplayName = $appName } }
            # servicePrincipals POST: create SP
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq '/beta/servicePrincipals' -and $Method -eq 'POST' } -MockWith { @{ Id = $spId; DisplayName = $appName } }

            # applications GET by id (no roles yet)
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq "/beta/applications/$applicationId" -and $Method -eq 'GET' } -MockWith { @{ AppRoles = @() } }
            # applications PATCH to add roles
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq "/beta/applications/$applicationId" -and $Method -eq 'PATCH' } -MockWith { @{ } }

            # servicePrincipals GET by id (expose role for assignment)
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq "/beta/servicePrincipals/$spId" -and $Method -eq 'GET' } -MockWith { @{ AppRoles = @(@{ displayName = $roleName; Id = [guid]::NewGuid().ToString() }) } }
            # servicePrincipals GET assignments: none
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq "/beta/servicePrincipals/$spId/appRoleAssignedTo" -and $Method -eq 'GET' } -MockWith { @{ value = @() } }
            # servicePrincipals POST assignment
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq "/beta/servicePrincipals/$spId/appRoleAssignments" -and $Method -eq 'POST' } -MockWith { @{ Id = 'assign1' } }

            # Act
            $result = Set-EntraBetaAppRoleToApplicationUser -DataSource Generic -FilePath $csvPath -ApplicationName $appName

            # Assert
            $result | Should -Not -BeNullOrEmpty
            @($result).Count | Should -Be 1

            # Spot-check key Graph calls happened
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter { $Uri -like '/beta/users*' -and $Method -eq 'POST' }
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -Times 1 -ParameterFilter { $Uri -eq "/beta/servicePrincipals/$spId/appRoleAssignments" -and $Method -eq 'POST' }
        }

        It "Should export results when -Export is used" {
            $exportPath = Join-Path $TestDrive "out.csv"

            # users/app/sp/roles/assignment mocks (same as previous test)
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -like '/beta/users*' -and $Method -eq 'GET' } -MockWith { @{ value = @() } }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -like '/beta/users*' -and $Method -eq 'POST' } -MockWith { @{ Id = 'u1'; UserPrincipalName = 'user1@contoso.com'; DisplayName = 'User One'; MailNickname = 'userone'; Mail = 'user1@contoso.com' } }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -like '/beta/applications?*' -and $Method -eq 'GET' } -MockWith { @{ value = @() } }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq '/beta/applications' -and $Method -eq 'POST' } -MockWith { @{ Id = $applicationId; AppId = $appAppId; DisplayName = $appName } }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq '/beta/servicePrincipals' -and $Method -eq 'POST' } -MockWith { @{ Id = $spId; DisplayName = $appName } }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq "/beta/applications/$applicationId" -and $Method -eq 'GET' } -MockWith { @{ AppRoles = @() } }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq "/beta/applications/$applicationId" -and $Method -eq 'PATCH' } -MockWith { @{ } }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq "/beta/servicePrincipals/$spId" -and $Method -eq 'GET' } -MockWith { @{ AppRoles = @(@{ displayName = $roleName; Id = [guid]::NewGuid().ToString() }) } }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq "/beta/servicePrincipals/$spId/appRoleAssignedTo" -and $Method -eq 'GET' } -MockWith { @{ value = @() } }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Governance -ParameterFilter { $Uri -eq "/beta/servicePrincipals/$spId/appRoleAssignments" -and $Method -eq 'POST' } -MockWith { @{ Id = 'assign1' } }

            # Act
            $result = Set-EntraBetaAppRoleToApplicationUser -DataSource Generic -FilePath $csvPath -ApplicationName $appName -Export -ExportFilePath $exportPath

            # Assert
            Test-Path $exportPath | Should -BeTrue
            (Import-Csv -Path $exportPath).Count | Should -Be 1
            @($result).Count | Should -Be 1
        }
    }
}
