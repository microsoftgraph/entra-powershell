# Contributing to Microsoft Entra PowerShell

This repository contains PowerShell cmdlets for developers and administrators to develop, deploy,
administer, and manage Microsoft Entra product family resources.

## Basics

If you would like to become a contributor to this project (or any other open source Microsoft
project), see how to [Get Involved](https://opensource.microsoft.com/collaborate/).

## Before Starting

### Onboarding

All users must sign the
[Microsoft Contributor License Agreement (CLA)](https://cla.opensource.microsoft.com/) before making
any code contributions. For Microsoft employees, make sure that your GitHub account is part of the
Microsoft Graph organization. [Use this page](https://repos.opensource.microsoft.com/) to link your account.

### Code of Conduct

This project adopts the
[Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more
information, see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any more questions or
comments.

### GitHub Basics

#### GitHub Workflow

The following guides provide basic knowledge for understanding Git command usage and the workflow of
GitHub.

- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [GitHub Flow](https://guides.github.com/introduction/flow/)

#### Forking the microsoftgraph/entra-powershell repository

Unless you're working with multiple contributors on the same file, we ask that you fork the
repository and submit your pull request from there. The following guide explains how to fork a
GitHub repo.

- [Contributing to GitHub projects](https://guides.github.com/activities/forking/).

## Filing Issues

You can find all of the issues filed for Microsoft Entra PowerShell in the
[Issues](https://aka.ms/entra/ps/issues) section of this repository.

To file an issue, select one of the
[templates](https://github.com/microsoftgraph/entra-powershell/issues/new/choose). The template ensures that all of
the necessary information is provided. The following are a few of the templates we provide:

- [_Entra PowerShell module bug report_](https://github.com/microsoftgraph/entra-powershell/issues/new?assignees=&labels=ToTriage&projects=&template=entra-powershell-bug-report.md)
- [_Feature request_](https://github.com/microsoftgraph/entra-powershell/issues/new?assignees=&labels=ToTriage&projects=&template=feature_request.md&title=%5BFeature%5D%3A+)

You can find the code complete and release dates of the upcoming Entra PowerShell releases in the
[Milestones](https://github.com/microsoftgraph/entra-powershell/milestones) section of the _Issues_ page.
Each milestone displays the issues that are being worked on for the corresponding release.

## Submitting Changes

### Pull Requests

You can find all of the pull requests that opened in the
[Pull Requests](https://github.com/microsoftgraph/entra-powershell/pulls) section of this repository.

When creating a pull request, keep the following in mind:

- Verify you're pointing to the fork and branch that your changes were made in.
- Choose the correct branch you want your pull request to be merged into.
  - The **main** branch is for active development; changes in this branch will be in the next Entra
    PowerShell release.
- The pull request template that is provided **must be filled out**. Don't delete or ignore it when
  the pull request is created.
  - **_IMPORTANT:_** Deleting or ignoring the pull request template delays the PR review process.
- The SLA for reviewing pull requests is **three business days**.

### Pull Request Guidelines

A pull request template will automatically be included as a part of your PR. Fill out the
checklist as specified. Pull requests **will not be reviewed** unless they include a properly
completed checklist.

#### Testing guidelines

The following guidelines must be followed in **every** pull request that is opened.

- Changes made have corresponding test coverage.
- Tests shouldn't include any hardcoded values, such as DisplayName, resource ID, etc.
- No existing tests should be skipped.

## Microsoft Entra PowerShell documentation contributions

The official Microsoft Entra PowerShell documentation is available on [learn.microsoft.com][entra-powershell-docs].

We welcome public contributions to the Microsoft Entra PowerShell documentation. There are two types of documentation for Microsoft Entra PowerShell, each with a different workflow:

- **Conceptual Documentation:** To submit changes for content in the `conceptual` directory, make a pull request against the [public docs repository][entra-powershell-public-docs-repo]. See more details, [Contributing][entra-powershell-docs-contribution] guide.
- **Reference Documentation:** To submit changes for command-line help and online documentation for both `beta` and `v1.0` versions of the module, make a pull request against [microsoftgraph/entra-powershell][entra-powershell-source-repo]. Updates are pushed to [learn.microsoft.com][entra-powershell-docs] every **two weeks**.

> **Note:** The Microsoft Entra PowerShell module reference documentation generates both the command-line help and public cmdlet references with the single source of truth being the [microsoftgraph/entra-powershell][entra-powershell-source-repo].

[entra-powershell-docs]: https://learn.microsoft.com/powershell/entra-powershell
[entra-powershell-source-repo]: https://github.com/microsoftgraph/entra-powershell/tree/main/module/docs
[entra-powershell-public-docs-repo]: https://github.com/MicrosoftDocs/entra-powershell-docs/tree/main/docs/conceptual
[entra-powershell-docs-contribution]: https://github.com/MicrosoftDocs/entra-powershell-docs/blob/main/CONTRIBUTING.md
