# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ($null -eq (Get-Module -Name Microsoft.Entra.Authentication)) {
        Import-Module Microsoft.Entra.Authentication
    }

    Mock -CommandName Connect-MgGraph -MockWith {} -ModuleName Microsoft.Entra.Authentication

    $ConnectEntraCommand = Get-Command Connect-Entra
}

Describe "Connect-Entra Mock" {

    It "Should return error when TenantId is null" {
        { Connect-Entra -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
    }
    It "Should return error when Environment is null" {
        { Connect-Entra -Environment } | Should -Throw "Missing an argument for parameter 'Environment'*"
    }
    It "Should return error when invalid parameter is provided" {
        { Connect-Entra -DisplayName } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'*"
    }
}

Describe "Connect-Entra ParameterSets" {
    It 'Should have six ParameterSets' {
        $ConnectEntraCommand | Should -Not -BeNullOrEmpty
        $ConnectEntraCommand.ParameterSets | Should -HaveCount 6
    }
    It 'Should have UserParameterSet' {
        $UserParameterSet = $ConnectEntraCommand.ParameterSets | Where-Object Name -eq 'UserParameterSet'
        $UserParameterSet | Should -Not -BeNull
        $UserParameterSet.IsDefault | Should -BeTrue
        $UserParameterSet.Parameters | Where-Object IsMandatory | Should -HaveCount 0
        @('ClientId', 'TenantId', 'ContextScope', 'Environment', 'ClientTimeout') | Should -BeIn $UserParameterSet.Parameters.Name
    }
    It 'Should have AppCertificateParameterSet' {
        $AppCertificateParameterSet = $ConnectEntraCommand.ParameterSets | Where-Object Name -eq 'AppCertificateParameterSet'
        $AppCertificateParameterSet | Should -Not -BeNull
        @('ClientId', 'TenantId', 'CertificateSubjectName', 'CertificateThumbprint', 'ContextScope', 'Environment', 'ClientTimeout') | Should -BeIn $AppCertificateParameterSet.Parameters.Name
    }

    It 'Should have AppSecretCredentialParameterSet' {
        $AppSecretCredentialParameterSet = $ConnectEntraCommand.ParameterSets | Where-Object Name -eq 'AppSecretCredentialParameterSet'
        $AppSecretCredentialParameterSet | Should -Not -BeNull
        @('ClientSecretCredential', 'TenantId', 'ContextScope', 'Environment', 'ClientTimeout') | Should -BeIn $AppSecretCredentialParameterSet.Parameters.Name
        $MandatoryParameters = $AppSecretCredentialParameterSet.Parameters | Where-Object IsMandatory
        $MandatoryParameters | Should -HaveCount 0
    }

    It 'Should have EnvironmentVariableParameterSet' {
        $EnvironmentVariableParameterSet = $ConnectEntraCommand.ParameterSets | Where-Object Name -eq 'EnvironmentVariableParameterSet'
        $EnvironmentVariableParameterSet | Should -Not -BeNull
        @('EnvironmentVariable', 'ContextScope', 'Environment', 'ClientTimeout') | Should -BeIn $EnvironmentVariableParameterSet.Parameters.Name
        $MandatoryParameters = $EnvironmentVariableParameterSet.Parameters | Where-Object IsMandatory
        $MandatoryParameters | Should -HaveCount 0
    }

    It 'Should Have AccessTokenParameterSet' {
        $AccessTokenParameterSet = $ConnectEntraCommand.ParameterSets | Where-Object Name -eq 'AccessTokenParameterSet'
        $AccessTokenParameterSet | Should -Not -BeNull
        @('AccessToken', 'Environment', 'ClientTimeout') | Should -BeIn $AccessTokenParameterSet.Parameters.Name
    }

    It "Should execute successfully without throwing an error" {
        # Disable confirmation prompts
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Connect-Entra -TenantId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -ApplicationId "00001111-aaaa-2222-bbbb-3333cccc4444" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference
            $DebugPreference = $originalDebugPreference
        }
    }
}

Describe "Connect-Entra ContextScope" {
    # Regression coverage for microsoftgraph/entra-powershell#1614. Microsoft.Graph.Authentication 2.41.0 moved its
    # ContextScope enum into a private AssemblyLoadContext on PowerShell 7, so a parameter typed with that enum
    # fails with "Unable to find type" on every call. The parameter must therefore stay a plain string.
    It 'Should not constrain any parameter to a Microsoft.Graph type' {
        $typeConstraints = $ConnectEntraCommand.ScriptBlock.Ast.Body.ParamBlock.Parameters.Attributes | Where-Object { $_ -is [System.Management.Automation.Language.TypeConstraintAst] }
        $typeConstraints.TypeName.FullName | Where-Object { $_ -like 'Microsoft.Graph.*' } | Should -BeNullOrEmpty
    }
    It 'Should declare ContextScope as a string limited to Process and CurrentUser' {
        $contextScope = $ConnectEntraCommand.Parameters['ContextScope']
        $contextScope.ParameterType | Should -Be ([string])
        $validateSet = $contextScope.Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }
        $validateSet | Should -HaveCount 1
        $validateSet.ValidValues | Should -Be @('Process', 'CurrentUser')
    }
    It 'Should reject a ContextScope value other than Process or CurrentUser' {
        { Connect-Entra -ContextScope 'Tenant' } | Should -Throw "Cannot validate argument on parameter 'ContextScope'*"
    }
}