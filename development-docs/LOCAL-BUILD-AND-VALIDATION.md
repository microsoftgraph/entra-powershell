# Local Build and Validation Guide

This guide walks you through the complete process of building, validating, and testing the Microsoft Entra PowerShell module on your local machine. Follow these steps to verify your changes before submitting a pull request.

## Table of Contents

- [Quick Start](#quick-start)
- [Detailed Build Steps](#detailed-build-steps)
  - [Step 1: Clone and Set Up](#step-1-clone-and-set-up)
  - [Step 2: Install Dependencies](#step-2-install-dependencies)
  - [Step 3: Build the Module](#step-3-build-the-module)
  - [Step 4: Import and Verify](#step-4-import-and-verify)
  - [Step 5: Run Tests](#step-5-run-tests)
  - [Step 6: Run Static Analysis](#step-6-run-static-analysis)
- [Safe Testing Practices](#safe-testing-practices)
- [Installing a Test Version Locally](#installing-a-test-version-locally)
- [Validating Documentation Changes](#validating-documentation-changes)
- [Complete Build Scripts](#complete-build-scripts)
- [CI/CD Pipeline Expectations](#cicd-pipeline-expectations)

## Quick Start

For contributors who want the shortest path to building and testing:

```powershell
# Clone and enter the repository
git clone https://github.com/<YOUR-USERNAME>/entra-powershell.git
cd entra-powershell

# Install dependencies
.\build\Install-Dependencies.ps1 -ModuleName Entra

# Install help generation tool
Install-Module -Name PlatyPS -Scope CurrentUser -Force

# Build the module
. .\build\Common-functions.ps1
Create-ModuleHelp -Module Entra
.\build\Create-EntraModule.ps1 -Module 'Entra'
.\build\Create-EntraModule.ps1 -Module 'Entra' -Root

# Import the module
Import-Module .\bin\Microsoft.Entra.psd1 -Force

# Run tests
Invoke-Pester -Path .\test\Entra\ -Output Detailed
```

## Detailed Build Steps

### Step 1: Clone and Set Up

Clone the repository directly (do not fork — fork-based PRs cannot run the CI pipeline):

```powershell
git clone https://github.com/microsoftgraph/entra-powershell.git
cd entra-powershell
```

Create a feature branch for your changes:

```powershell
git checkout -b feature/your-change-description
```

Create a feature branch for your changes:

```powershell
git checkout -b feature/your-change-description
```

> **Important**: Always use a **fresh PowerShell session** when building. If a different version of the module dependencies is already loaded in your session, the build will fail.

### Step 2: Install Dependencies

The module requires specific versions of the Microsoft Graph PowerShell SDK modules (v2.25.x or later).

**For the v1.0 module:**

```powershell
.\build\Install-Dependencies.ps1 -ModuleName Entra
```

**For the Beta module:**

```powershell
.\build\Install-Dependencies.ps1 -ModuleName EntraBeta
```

Install the PlatyPS module (required for generating help documentation):

```powershell
Install-Module -Name PlatyPS -Scope CurrentUser -Force
```

> **Tip**: If you get an execution policy error, run:
> ```powershell
> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

### Step 3: Build the Module

**Build help documentation:**

```powershell
. .\build\Common-functions.ps1
Create-ModuleHelp -Module Entra
```

**Build the module:**

```powershell
.\build\Create-EntraModule.ps1 -Module 'Entra'
.\build\Create-EntraModule.ps1 -Module 'Entra' -Root
```

The built module is output to the `./bin` directory.

### Step 4: Import and Verify

Import the built module to verify it loads without errors:

```powershell
Import-Module .\bin\Microsoft.Entra.psd1 -Force
```

Verify the module is loaded:

```powershell
Get-Module Microsoft.Entra* | Format-Table Name, Version, ExportedCommands
```

Test that your cmdlet is available:

```powershell
Get-Command -Module Microsoft.Entra* -Name <YourCmdletName>
```

> **PowerShell 5.1 users**: If you see `Function capacity 4096 exceeded`, run `$MaximumFunctionCount = 32768` before importing.

### Step 5: Run Tests

Run all unit tests to ensure nothing is broken:

```powershell
# Run all v1.0 tests
Invoke-Pester -Path .\test\Entra\ -Output Detailed

# Or run tests for a specific sub-module
Invoke-Pester -Path .\test\Entra\Users\ -Output Detailed

# Or run tests for your specific cmdlet
Invoke-Pester -Path .\test\Entra\Users\Get-EntraUser.Tests.ps1 -Output Detailed
```

For detailed testing instructions, see the [Testing Guide](./TESTING.md).

### Step 6: Run Static Analysis

Run PSScriptAnalyzer on your changed files to catch common issues:

```powershell
# Analyze a specific file
Invoke-ScriptAnalyzer -Path .\module\Entra\<YourFile>.ps1 -Severity Warning

# Analyze an entire sub-module
Invoke-ScriptAnalyzer -Path .\module\Entra\Users\ -Recurse -Severity Warning
```

## Safe Testing Practices

When testing changes locally, follow these practices to avoid unintended side effects:

### Use Mocked Tests (Recommended)

The project's unit tests use Pester mocks — they **never call the real Microsoft Graph API**. This is the safest way to test:

```powershell
# This is safe — all API calls are mocked
Invoke-Pester -Path .\test\Entra\Users\Get-EntraUser.Tests.ps1
```

### Use a Test Tenant for Manual Testing

If you need to manually test cmdlets against a real environment:

1. **Use a dedicated test/development tenant** — never test against production.
2. **Use least-privilege scopes** — only request the permissions you need:
   ```powershell
   Connect-Entra -Scopes "User.Read"
   ```
3. **Use read-only operations first** — verify with `Get-` cmdlets before using `Set-`, `New-`, or `Remove-` cmdlets.
4. **Use `-WhatIf` when available** — some cmdlets support `-WhatIf` to preview changes without applying them.
5. **Clean up after testing** — remove any test resources you created.

### Isolated Testing with a Local Gallery

To test the module installation experience without affecting your system:

```powershell
. .\build\Common-functions.ps1
Create-ModuleFolder
Register-LocalGallery
.\build\Publish-LocalCompatModule.ps1 -Install

# Test with the installed module
Import-Module Microsoft.Entra -Force

# Clean up when done
Unregister-LocalGallery
```

## Installing a Test Version Locally

If you want to install your locally-built module system-wide (useful for automation testing):

```powershell
# Set up a local PowerShell gallery
. .\build\Common-functions.ps1
Create-ModuleFolder
Register-LocalGallery

# Publish and install from local gallery
.\build\Publish-LocalCompatModule.ps1 -Install

# Now import without specifying a path
Import-Module Microsoft.Entra -Force
```

To clean up:

```powershell
# Unregister the local gallery
Unregister-LocalGallery

# Uninstall the test module
Uninstall-Module Microsoft.Entra -Force
```

## Validating Documentation Changes

If you've updated cmdlet documentation (markdown files in `module/docs/`):

### Build and Preview Help

```powershell
# Rebuild help files
. .\build\Common-functions.ps1
Create-ModuleHelp -Module Entra

# Import module with updated help
Import-Module .\bin\Microsoft.Entra.psd1 -Force

# Verify your help content
Get-Help <YourCmdletName> -Full
Get-Help <YourCmdletName> -Examples
```

### Validate Markdown Syntax

Ensure your documentation markdown is properly formatted:

- Examples must include `powershell` as the code fence language.
- Parameter descriptions must be present for all parameters.
- At least one example must be included per cmdlet.
- See the [cmdlet reference template](./cmdlet-references-documentation/cmdlet-reference-template.md) for the expected format.

## Complete Build Scripts

### v1.0 Module — Full Build and Test

```powershell
# Start a fresh PowerShell session before running this script
.\build\Install-Dependencies.ps1 -ModuleName Entra
Install-Module -Name PlatyPS -Scope CurrentUser -Force
. .\build\Common-functions.ps1
Create-ModuleHelp -Module Entra
.\build\Create-EntraModule.ps1 -Module 'Entra'
.\build\Create-EntraModule.ps1 -Module 'Entra' -Root
Import-Module .\bin\Microsoft.Entra.psd1 -Force

# Run all tests
Invoke-Pester -Path .\test\Entra\ -Output Detailed
```

### Beta Module — Full Build and Test

```powershell
# Start a fresh PowerShell session before running this script
.\build\Install-Dependencies.ps1 -ModuleName EntraBeta
Install-Module -Name PlatyPS -Scope CurrentUser -Force
. .\build\Common-functions.ps1
Create-ModuleHelp -Module EntraBeta
.\build\Create-EntraModule.ps1 -Module 'EntraBeta'
.\build\Create-EntraModule.ps1 -Module 'EntraBeta' -Root
Import-Module .\bin\Microsoft.Entra.Beta.psd1 -Force

# Run all tests
Invoke-Pester -Path .\test\EntraBeta\ -Output Detailed
```

## PR Pipeline Expectations

When you open a pull request, the PR pipeline automatically:

1. **Builds the module** — using Azure Pipelines on Windows.
2. **Runs PSScriptAnalyzer** — static analysis for code quality.
3. **Runs credential scanning** — ensures no secrets are committed.

To avoid surprises, replicate these checks locally before pushing:

```powershell
# 1. Build the module (see steps above)

# 2. Run static analysis
Invoke-ScriptAnalyzer -Path .\module\Entra\ -Recurse -Severity Warning

# 3. Run all tests
Invoke-Pester -Path .\test\Entra\ -Output Detailed

# 4. Verify no secrets are in your changes
git diff --cached --name-only  # Review staged files
```

> **Tip**: The PR review SLA is **three business days**. Complete the [PR template checklist](../CONTRIBUTING.md#pull-request-guidelines) to avoid delays.

> **Important**: Once your PR is complete and all checks pass, add the **Ready For Review** label to signal the team for review.

> **Note**: Pull requests from forks cannot run the CI pipeline because it requires access to internal build resources. Always clone the repository directly and push branches to the upstream repository.
