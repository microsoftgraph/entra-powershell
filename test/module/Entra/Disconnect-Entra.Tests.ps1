# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll{
    if($null -eq (Get-Module -Name Microsoft.Graph.Entra)){
        Import-Module Microsoft.Graph.Entra      
    }

    Mock -CommandName Disconnect-MgGraph -MockWith {} -ModuleName Microsoft.Graph.Entra

    $command = Get-Command Disconnect-Entra
}

Describe "Disconnect-Entra Mock"{
    It "should return empty object"{
        $result = Disconnect-Entra
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Disconnect-MgGraph -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should return error when invalid parameter is provided"{
        { Disconnect-MgGraph -DisplayName } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'*"
    }
}

Describe "Disconnect-Entra ParameterSets"{
    It 'Should have one ParameterSets' {
        $command | Should -Not -BeNullOrEmpty
        $command.ParameterSets | Should -HaveCount 1
    }
    It 'Should have GetQuery' {
        $UserParameterSet = $command.ParameterSets | Where-Object Name -eq 'GetQuery'
        $UserParameterSet | Should -Not -BeNull
        $UserParameterSet.IsDefault | Should -BeTrue
    }
}BeforeAll{
    if($null -eq (Get-Module -Name Microsoft.Graph.Entra)){
        Import-Module Microsoft.Graph.Entra      
    }

    Mock -CommandName Disconnect-MgGraph -MockWith {} -ModuleName Microsoft.Graph.Entra

    $command = Get-Command Disconnect-Entra
}

Describe "Disconnect-Entra Mock"{
    It "should return empty object"{
        $result = Disconnect-Entra
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Disconnect-MgGraph -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should return error when invalid parameter is provided"{
        { Disconnect-MgGraph -DisplayName } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'*"
    }
}

Describe "Disconnect-Entra ParameterSets"{
    It 'Should have one ParameterSets' {
        $command | Should -Not -BeNullOrEmpty
        $command.ParameterSets | Should -HaveCount 1
    }
    It 'Should have GetQuery' {
        $UserParameterSet = $command.ParameterSets | Where-Object Name -eq 'GetQuery'
        $UserParameterSet | Should -Not -BeNull
        $UserParameterSet.IsDefault | Should -BeTrue
    }
}