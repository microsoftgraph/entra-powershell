# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    $ModulePath = Join-Path $PSScriptRoot "..\..\..\module\Entra\Microsoft.Entra\Applications\Write-EntraInputValidationLog.ps1"
    . $ModulePath
}

Describe "Write-EntraInputValidationLog" {
    Context "Parameter validation" {
        It "Should require CmdletName parameter" {
            $param = (Get-Command Write-EntraInputValidationLog).Parameters['CmdletName']
            $param.Attributes.Where({ $_ -is [System.Management.Automation.ParameterAttribute] }).Mandatory | Should -Contain $true
        }

        It "Should require ParameterName parameter" {
            $param = (Get-Command Write-EntraInputValidationLog).Parameters['ParameterName']
            $param.Attributes.Where({ $_ -is [System.Management.Automation.ParameterAttribute] }).Mandatory | Should -Contain $true
        }

        It "Should accept all parameters without throwing" {
            { Write-EntraInputValidationLog -CmdletName 'Get-EntraUser' -ParameterName 'UserId' -InvalidValue 'bad-value-that-is-long' -ExpectedPattern 'GUID format' -Message 'Test message' } | Should -Not -Throw
        }

        It "Should work with only mandatory parameters" {
            { Write-EntraInputValidationLog -CmdletName 'Get-EntraUser' -ParameterName 'UserId' } | Should -Not -Throw
        }
    }

    Context "Non-fatal behavior" {
        It "Should not throw exceptions even when all logging fails" {
            Mock Out-File { throw "Disk full" }
            Mock Write-EventLog { throw "Access denied" }
            { Write-EntraInputValidationLog -CmdletName 'Test-Cmdlet' -ParameterName 'Param1' -InvalidValue 'bad' } | Should -Not -Throw
        }

        It "Should not throw if event log source does not exist" {
            Mock Write-EventLog { throw "Source does not exist" }
            { Write-EntraInputValidationLog -CmdletName 'Test-Cmdlet' -ParameterName 'Param1' } | Should -Not -Throw
        }
    }

    Context "Verbose output validation" {
        It "Should include structured log content in Verbose output" {
            $verboseOutput = Write-EntraInputValidationLog -CmdletName 'Get-EntraUser' -ParameterName 'UserId' -InvalidValue 'not-a-guid-value' -Verbose 4>&1
            $verboseText = $verboseOutput | Out-String
            $verboseText | Should -BeLike '*InputValidationFailure*'
            $verboseText | Should -BeLike '*CmdletName=Get-EntraUser*'
            $verboseText | Should -BeLike '*ParameterName=UserId*'
        }

        It "Should include timestamp in verbose output" {
            $verboseOutput = Write-EntraInputValidationLog -CmdletName 'Test' -ParameterName 'P1' -Verbose 4>&1
            $verboseText = $verboseOutput | Out-String
            $verboseText | Should -BeLike '*Timestamp=*'
        }

        It "Should include user identity in verbose output" {
            $verboseOutput = Write-EntraInputValidationLog -CmdletName 'Test' -ParameterName 'P1' -Verbose 4>&1
            $verboseText = $verboseOutput | Out-String
            $verboseText | Should -BeLike '*User=*'
        }
    }

    Context "Value masking in verbose output" {
        It "Should mask values longer than 8 characters showing only first 4" {
            $verboseOutput = Write-EntraInputValidationLog -CmdletName 'Test' -ParameterName 'P1' -InvalidValue 'VeryLongInvalidValue123' -Verbose 4>&1
            $verboseText = $verboseOutput | Out-String
            $verboseText | Should -BeLike '*Very`*`*`*`**'
            $verboseText | Should -Not -BeLike '*VeryLongInvalidValue123*'
        }

        It "Should fully mask values 8 characters or shorter" {
            $verboseOutput = Write-EntraInputValidationLog -CmdletName 'Test' -ParameterName 'P1' -InvalidValue 'short' -Verbose 4>&1
            $verboseText = $verboseOutput | Out-String
            $verboseText | Should -BeLike '*InvalidValue=`*`*`*`**'
            $verboseText | Should -Not -BeLike '*short*'
        }

        It "Should show [empty] for null or empty values" {
            $verboseOutput = Write-EntraInputValidationLog -CmdletName 'Test' -ParameterName 'P1' -InvalidValue '' -Verbose 4>&1
            $verboseText = $verboseOutput | Out-String
            $verboseText | Should -BeLike '*`[empty`]*'
        }
    }

    Context "Expected pattern and message" {
        It "Should show N/A for missing expected pattern" {
            $verboseOutput = Write-EntraInputValidationLog -CmdletName 'Test' -ParameterName 'P1' -Verbose 4>&1
            $verboseText = $verboseOutput | Out-String
            $verboseText | Should -BeLike '*ExpectedPattern=N/A*'
        }

        It "Should include expected pattern when provided" {
            $verboseOutput = Write-EntraInputValidationLog -CmdletName 'Test' -ParameterName 'P1' -ExpectedPattern 'GUID format' -Verbose 4>&1
            $verboseText = $verboseOutput | Out-String
            $verboseText | Should -BeLike '*ExpectedPattern=GUID format*'
        }

        It "Should include message when provided" {
            $verboseOutput = Write-EntraInputValidationLog -CmdletName 'Test' -ParameterName 'P1' -Message 'Custom error message' -Verbose 4>&1
            $verboseText = $verboseOutput | Out-String
            $verboseText | Should -BeLike '*Message=Custom error message*'
        }
    }
}
