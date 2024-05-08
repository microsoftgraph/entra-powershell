BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        # Write-Host "Mocking Set-EntraUserLicense with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                userPrincipalName = "test122@M365x99297270.OnMicrosoft.com"
                preferredLanguage = "EN"
                mobilePhone = "9984534564"
                displayName = "SNEHALtest"
                givenName = "test12"
                mail = "test122@M365x99297270.OnMicrosoft.com"
                '@odata.context' = "https://graph.microsoft.com/v1.0/$metadata#users/$entity"
                id = "1139c016-f606-45f0-83f7-40eb2a552a6f"
                jobTitle = "testqa"
                officeLocation = "test"
                businessPhones = @("8976546787")
                surname = "KTETSs"            
                Parameters                 = $args
            }
        )

    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraUserLicense" {
    Context "Test for Set-EntraUserLicense" {
        It "Should return specific User" {
            $addLicensesArray = [PSCustomObject]@{
            skuId = "f30db892-07e9-47e9-837c-80727f46fd3d"
            }
            $Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
            $Licenses.AddLicenses =$addLicensesArray
            $result =  Set-EntraUserLicense -ObjectId 1139c016-f606-45f0-83f7-40eb2a552a6f -AssignedLicenses $Licenses

            $result | Should -Not -BeNullOrEmpty
            $result.userPrincipalName | Should -Be "test122@M365x99297270.OnMicrosoft.com"
            $result.preferredLanguage | Should -Be "EN"
            $result.mobilePhone | Should -Be "9984534564"
            $result.displayName | Should -Be "SNEHALtest"
            $result.givenName | Should -Be "test12"
            $result.mail | Should -Be "test122@M365x99297270.OnMicrosoft.com"
            $result.'@odata.context' | Should -Be "https://graph.microsoft.com/v1.0/$metadata#users/$entity"
            $result.id | Should -Be "1139c016-f606-45f0-83f7-40eb2a552a6f"
            $result.jobTitle | Should -Be "testqa"
            $result.officeLocation | Should -Be "test"
            $result.businessPhones | Should -Be @("8976546787")
            $result.surname | Should -Be "KTETSs"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty string value" {
            { Set-EntraUserLicense -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when ObjectId is empty" {
            { Set-EntraUserLicense -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should fail when AssignedLicenses is empty" {
            { Set-EntraUserLicense -ObjectId  1139c016-f606-45f0-83f7-40eb2a552a6f -AssignedLicenses } | Should -Throw "Missing an argument for parameter 'AssignedLicenses'. Specify a parameter of type 'Microsoft.Open.AzureAD.Model.AssignedLicenses' and try again."
        }

        It "Should contain UserId in parameters when passed ObjectId to it" {
            $addLicensesArray = [PSCustomObject]@{
                skuId = "f30db892-07e9-47e9-837c-80727f46fd3d"
                }
            $Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
            $Licenses.AddLicenses =$addLicensesArray
            $result =  Set-EntraUserLicense -ObjectId 1139c016-f606-45f0-83f7-40eb2a552a6f -AssignedLicenses $Licenses
    
            $params = Get-Parameters -data $result.Parameters
            $params.Uri | Should -Match "1139c016-f606-45f0-83f7-40eb2a552a6f"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserLicense"

            $addLicensesArray = [PSCustomObject]@{
                skuId = "f30db892-07e9-47e9-837c-80727f46fd3d"
            }
            $Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
            $Licenses.AddLicenses =$addLicensesArray
            $result =  Set-EntraUserLicense -ObjectId 1139c016-f606-45f0-83f7-40eb2a552a6f -AssignedLicenses $Licenses

            $params = Get-Parameters -data $result.Parameters

            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }  

    }
}