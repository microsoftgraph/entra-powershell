# Prerequisites

To use this module, you must have the appropriate version of the [Microsoft Graph PowerShell SDK](https://learn.microsoft.com/powershell/microsoftgraph/installation). Specifically, this release requires version 2.15.0 or higher.

## PowerShell Gallery Installation

When installing the module from the PowerShell Gallery, all necessary dependencies are installed automatically.

## Required Modules for Local Building

This module does not require the entire Microsoft Graph PowerShell SDK, only the following specific modules:

### v1.0 modules

- Microsoft.Graph.DirectoryObjects
- Microsoft.Graph.Users
- Microsoft.Graph.Users.Actions
- Microsoft.Graph.Users.Functions
- Microsoft.Graph.Groups
- Microsoft.Graph.Identity.DirectoryManagement
- Microsoft.Graph.Identity.Governance
- Microsoft.Graph.Identity.SignIns
- Microsoft.Graph.Applications

### Beta

- Microsoft.Graph.Beta.Applications
- Microsoft.Graph.Beta.Users
- Microsoft.Graph.Beta.Users.Actions
- Microsoft.Graph.Beta.Users.Functions
- Microsoft.Graph.Beta.Groups
- Microsoft.Graph.Beta.Identity.DirectoryManagement
- Microsoft.Graph.Beta.Identity.Governance
- Microsoft.Graph.Beta.Identity.SignIns
- Microsoft.Graph.Beta.Reports
