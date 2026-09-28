# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications
    }

    Mock -CommandName Add-MgApplicationKey -MockWith { [PSCustomObject]@{ Id = $ApplicationId } } -ModuleName Microsoft.Entra.Applications -RemoveParameterType KeyCredential
    Mock -CommandName Get-EntraContext -MockWith { @{ Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
}

Describe "New-EntraApplicationKey" {
    It "Should redact Proof from debug output without changing the Graph request" {
        $proof = "eyJhbGciOiJSUzI1NiJ9.sensitive-proof.signature"
        $keyCredential = [Microsoft.Open.MSGraph.Model.KeyCredential]::new()

        $output = New-EntraApplicationKey `
            -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" `
            -KeyCredential $keyCredential `
            -Proof $proof `
            -Debug 5>&1
        $debugOutput = ($output | Where-Object { $_ -is [System.Management.Automation.DebugRecord] }) -join "`n"

        $debugOutput | Should -Match "Proof : \[REDACTED\]"
        $debugOutput | Should -Not -Match ([regex]::Escape($proof))
        Should -Invoke -CommandName Add-MgApplicationKey -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
            $Proof -eq $proof
        }
    }
}
