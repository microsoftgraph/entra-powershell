# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Describe "Get-AzureADApplication" {
    BeforeAll {
        $GetAzureADApplication = Get-Command Get-AzureADApplication
    }

    It "Should support minimum set of parameter sets" {
        $GetAzureADApplication.ParameterSets.Name | Should -BeIn @("GetQuery", "GetVague", "GetById")
        $GetAzureADApplication.Visibility | Should -Be "Public"
        $GetAzureADApplication.CommandType | Should -Be "Cmdlet"
    }

    It "Should return a list of applications by default" {
        $GetAzureADApplication.ImplementingType | Should -Be "Microsoft.Open.AzureAD16.PowerShell.GetApplication"
        $GetAzureADApplication.DefaultParameterSet | Should -Be "GetQuery"
    }

    It 'Should have List parameterSet' {
        $ListParameterSet = $GetAzureADApplication.ParameterSets | Where-Object Name -eq "GetQuery"
        $ListParameterSet.Parameters.Name | Should -Contain All
        $ListParameterSet.Parameters.Name | Should -Contain Filter
        $ListParameterSet.Parameters.Name | Should -Contain Top
    }

    It 'Should have Get parameterSet' {
        $GetParameterSet = $GetAzureADApplication.ParameterSets | Where-Object Name -eq "GetById"
        $GetParameterSet.Parameters.Name | Should -Contain ObjectId
    }

    It 'Should have GetViaIdentity parameterSet' {
        $GetViaIdentityParameterSet = $GetAzureADApplication.ParameterSets | Where-Object Name -eq "GetVague"
        $GetViaIdentityParameterSet.Parameters.Name | Should -Contain SearchString
        $GetViaIdentityParameterSet.Parameters.Name | Should -Contain All
    }
}