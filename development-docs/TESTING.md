# Testing Guide for Microsoft Entra PowerShell

This guide provides clear, step-by-step instructions for contributors on how to test changes locally before submitting a pull request. Following these practices ensures code quality and reduces review turnaround time.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Test Framework Overview](#test-framework-overview)
- [Running Tests Locally](#running-tests-locally)
  - [Running All Tests](#running-all-tests)
  - [Running Specific Tests](#running-specific-tests)
  - [Running Tests for a Module](#running-tests-for-a-module)
- [Writing Tests](#writing-tests)
  - [Test File Structure](#test-file-structure)
  - [Mocking Best Practices](#mocking-best-practices)
  - [Test Naming Conventions](#test-naming-conventions)
- [Code Coverage](#code-coverage)
- [Test Checklist Before Submitting a PR](#test-checklist-before-submitting-a-pr)
- [Troubleshooting](#troubleshooting)

## Prerequisites

Before running tests, ensure you have the following installed:

- **PowerShell 7+** (recommended) or Windows PowerShell 5.1
- **Pester** (v5+) — the PowerShell testing framework
- **PSScriptAnalyzer** — for static code analysis
- The module built locally (see [BUILD.md](../build/BUILD.md))

Install Pester and PSScriptAnalyzer if not already installed:

```powershell
Install-Module -Name Pester -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force
```

## Test Framework Overview

Microsoft Entra PowerShell uses the [Pester](https://pester.dev) testing framework. Tests are organized by module and cmdlet:

```
test/
├── Common-Functions.ps1          # Shared test utilities
├── Entra/                        # v1.0 module tests
│   ├── Entra.Tests.ps1           # Test runner for all v1.0 tests
│   ├── Applications/             # Application cmdlet tests
│   ├── Users/                    # User cmdlet tests
│   ├── Groups/                   # Group cmdlet tests
│   ├── DirectoryManagement/      # Directory management tests
│   ├── Governance/               # Governance tests
│   ├── SignIns/                   # Sign-in tests
│   ├── Reports/                  # Report tests
│   └── Authentication/           # Authentication tests
└── EntraBeta/                    # Beta module tests (same structure)
```

Each cmdlet has a corresponding `.Tests.ps1` file (for example, `Get-EntraUser.Tests.ps1`).

## Running Tests Locally

### Running All Tests

To run the full test suite for the v1.0 module:

```powershell
# 1. Build the module first (see build/BUILD.md)
# 2. Run all tests
cd entra-powershell
.\test\Entra\Entra.Tests.ps1
```

For the Beta module:

```powershell
.\test\EntraBeta\EntraBeta.Tests.ps1
```

### Running Specific Tests

To run a single test file:

```powershell
# Run tests for a specific cmdlet
Invoke-Pester -Path .\test\Entra\Users\Get-EntraUser.Tests.ps1 -Output Detailed
```

To run tests matching a specific name pattern:

```powershell
# Run only tests with "Delete" in the name
Invoke-Pester -Path .\test\Entra\Users\ -TagFilter "Delete" -Output Detailed
```

### Running Tests for a Module

To run all tests for a specific sub-module (e.g., Users):

```powershell
Invoke-Pester -Path .\test\Entra\Users\ -Output Detailed
```

### Running Tests with Pester Configuration

For more control, use a Pester configuration object:

```powershell
$config = New-PesterConfiguration
$config.Run.Path = ".\test\Entra\Users\"
$config.Run.PassThru = $true
$config.Output.Verbosity = "Detailed"
$config.TestResult.Enabled = $true
$config.TestResult.OutputPath = ".\TestReport\TestResults.xml"

Invoke-Pester -Configuration $config
```

## Writing Tests

### Test File Structure

Every test file follows this structure:

```powershell
# Copyright header
BeforeAll {
    # Import the module under test
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    # Define mock data
    $mockUser = {
        return @( [PSCustomObject]@{
            Id              = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            DisplayName     = "Test User"
            UserPrincipalName = "testuser@contoso.com"
        })
    }

    # Set up mocks
    Mock -CommandName Get-MgUser -MockWith $mockUser -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith {
        @{ Scopes = @("User.Read.All") }
    } -ModuleName Microsoft.Entra.Users
}

Describe "Get-EntraUser" {
    Context "Test for Get-EntraUser" {
        It "Should return a user by ID" {
            $result = Get-EntraUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgUser -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when UserId is empty" {
            { Get-EntraUser -UserId } | Should -Throw "Missing an argument*"
        }
    }
}
```

### Mocking Best Practices

Tests must **never** make real API calls. Always use Pester mocks:

1. **Mock all Microsoft Graph SDK calls** — Use `Mock -CommandName <GraphCmdlet> -MockWith <ScriptBlock> -ModuleName <Module>` for every Graph SDK cmdlet your code calls.

2. **Mock `Get-EntraContext`** — All cmdlets check for an active connection. Mock this to return a valid context:
   ```powershell
   Mock -CommandName Get-EntraContext -MockWith {
       @{ Scopes = @("User.Read.All") }
   } -ModuleName Microsoft.Entra.Users
   ```

3. **Test the not-connected scenario** — Ensure your cmdlet fails gracefully when not connected:
   ```powershell
   It "should throw when not connected" {
       Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
       { Get-EntraUser -UserId "test-id" } | Should -Throw "Not connected to Microsoft Graph*"
   }
   ```

4. **Use placeholder IDs** — Never use real resource IDs. Use the format `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`.

5. **Use placeholder names and emails** — Use fictitious names like `contoso.com` domains.

### Test Naming Conventions

- **Test file**: Name it the same as the cmdlet — `<CmdletName>.Tests.ps1`
- **Describe block**: Use the cmdlet name — `Describe "Get-EntraUser"`
- **Context block**: Group related scenarios — `Context "Test for Get-EntraUser"`
- **It block**: Use descriptive names starting with "Should" — `It "Should return all users when -All is specified"`

### What to Test

Every cmdlet test should cover:

| Scenario | Example |
|----------|---------|
| Success with required parameters | `It "Should return a user by ID"` |
| Success with optional parameters | `It "Should return top N users"` |
| Parameter aliases | `It "Should work with -Id alias"` |
| Missing required parameters | `It "Should fail when UserId is empty"` |
| Invalid parameter values | `It "Should fail when Top is not a number"` |
| Not-connected state | `It "Should throw when not connected"` |
| Pipeline support (if applicable) | `It "Should accept pipeline input"` |
| `-All` switch (if applicable) | `It "Should return all results with -All"` |

## Code Coverage

The test runner is configured to target **100% code coverage**. To generate a code coverage report:

```powershell
$config = New-PesterConfiguration
$config.Run.Path = ".\test\Entra\Users\"
$config.CodeCoverage.Enabled = $true
$config.CodeCoverage.Path = ".\module\Entra\Microsoft.Entra"
$config.CodeCoverage.CoveragePercentTarget = 100
$config.Output.Verbosity = "Detailed"

Invoke-Pester -Configuration $config
```

Coverage reports are saved to the `TestReport/` directory.

## Test Checklist Before Submitting a PR

Before creating a pull request, verify the following:

- [ ] **All existing tests pass** — Run the full test suite and confirm zero failures.
- [ ] **New cmdlets have corresponding tests** — Every new cmdlet must have a `.Tests.ps1` file.
- [ ] **No hardcoded values** — Tests must not contain real resource IDs, display names, or tenant-specific data.
- [ ] **No skipped tests** — Do not skip existing tests (`-Skip` is not allowed).
- [ ] **Mocks are used for all API calls** — No real Microsoft Graph API calls are made during testing.
- [ ] **Code coverage is maintained** — New code should be fully covered by tests.
- [ ] **PSScriptAnalyzer passes** — Run `Invoke-ScriptAnalyzer` on your changed files:
  ```powershell
  Invoke-ScriptAnalyzer -Path .\module\Entra\<YourCmdlet>.ps1 -Severity Warning
  ```

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| `Pester not found` | Run `Install-Module -Name Pester -Scope CurrentUser -Force -SkipPublisherCheck` |
| `Function capacity 4096 exceeded` | Set `$MaximumFunctionCount = 32768` before importing modules, or use PowerShell 7+ |
| `Execution policy error` | Run `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` |
| `Module not found during tests` | Build the module first using `.\build\Create-EntraModule.ps1` (see [BUILD.md](../build/BUILD.md)) |
| `Assembly already loaded` | Use a **fresh PowerShell session** — don't reuse sessions that have other module versions loaded |
| `Mock not applied` | Verify the `-ModuleName` parameter matches the module your cmdlet is in |

### Getting Help

- Check the [FAQ in BUILD.md](../build/BUILD.md#faqs)
- Open a [discussion](https://github.com/microsoftgraph/entra-powershell/discussions)
- File an [issue](https://aka.ms/entra/ps/issues) if you believe there's a bug in the test infrastructure
