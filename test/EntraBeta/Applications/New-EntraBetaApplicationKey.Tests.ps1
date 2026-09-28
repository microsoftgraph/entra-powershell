# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications
    }

    Mock -CommandName Add-MgBetaApplicationKey -MockWith { [PSCustomObject]@{ Id = $ApplicationId } } -ModuleName Microsoft.Entra.Beta.Applications -RemoveParameterType KeyCredential
    Mock -CommandName Get-EntraContext -MockWith { @{ Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "New-EntraBetaApplicationKey" {
    It "Should redact Proof from debug output without changing the Graph request" {
        $proof = "eyJhbGciOiJSUzI1NiJ9.sensitive-proof.signature"
        $keyCredential = [Microsoft.Open.MSGraph.Model.KeyCredential]::new()

        $output = New-EntraBetaApplicationKey `
            -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" `
            -KeyCredential $keyCredential `
            -Proof $proof `
            -Debug 5>&1
        $debugOutput = ($output | Where-Object { $_ -is [System.Management.Automation.DebugRecord] }) -join "`n"

        $debugOutput | Should -Match "Proof : \[REDACTED\]"
        $debugOutput | Should -Not -Match ([regex]::Escape($proof))
        Should -Invoke -CommandName Add-MgBetaApplicationKey -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
            $Proof -eq $proof
        }
    }
}
