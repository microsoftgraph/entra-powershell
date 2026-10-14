# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ($null -eq (Get-Module -Name Microsoft.Entra.Beta.Authentication)) {
        Import-Module Microsoft.Entra.Beta.Authentication
    }

    Mock -CommandName Connect-MgGraph -MockWith {} -ModuleName Microsoft.Entra.Beta.Authentication

    $ConnectEntraCommand = Get-Command Connect-Entra
}

Describe "Connect-Entra ParameterSets" {
    It 'Should have six ParameterSets' {
        $ConnectEntraCommand | Should -Not -BeNullOrEmpty
        $ConnectEntraCommand.ParameterSets | Should -HaveCount 6
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
