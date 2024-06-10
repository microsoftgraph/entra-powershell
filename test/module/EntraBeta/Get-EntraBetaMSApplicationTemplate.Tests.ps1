BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Categories"                    = "businessMgmt"
                "Description"                   = "Capture and manage your ESG data from across the organization in an integrated, cloud-based platform that connects organizational strategy, automates reporting, and simplifies stakeholder engagement."
                "DisplayName"                   = "FigBytes"
                "HomePageUrl"                   = "https://figbytes.biz/"
                "Id"                            = "5979191c-86e6-40f7-87ac-0913dddd1f61"
                "LogoUrl"                       = "https://galleryapplogos1.azureedge.net/app-logo/figbytes_AAA12D0E_215.png"
                "Publisher"                     = "Figbytes"
                "SupportedClaimConfiguration"   = [PSCustomObject]@{
                                                    "NameIdPolicyFormat" = $null
                                                }
                "SupportedProvisioningTypes"    = @()
                "SupportedSingleSignOnModes"    = @("saml", "external")
                "AdditionalProperties"          = @{"@odata.context" = "https://graph.microsoft.com/beta/$metadata#applicationTemplates/$entity"}
                "InformationalUrls"             = [PSCustomObject]@{
                                                    "AppSignUpUrl"                  = "https://go.microsoft.com/fwlink/?linkid=2190589"
                                                    "SingleSignOnDocumentationUrl"   = $null
                                                }
                "Parameters"             = $args
            }
        )
    }
    Mock -CommandName  Get-MgBetaApplicationTemplate -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaMSApplicationTemplate" {
    Context "Test for Get-EntraBetaMSApplicationTemplate" {
        It "Should get a specific application template" {
            $result = Get-EntraBetaMSApplicationTemplate -Id "5979191c-86e6-40f7-87ac-0913dddd1f61"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'FigBytes'
            $result.Description | should -Be  "Capture and manage your ESG data from across the organization in an integrated, cloud-based platform that connects organizational strategy, automates reporting, and simplifies stakeholder engagement."

            Should -Invoke -CommandName  Get-MgBetaApplicationTemplate -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraBetaMSApplicationTemplate -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaMSApplicationTemplate -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should get a list of all the application templates" {
            $result = Get-EntraBetaMSApplicationTemplate 
            $result | Should -Not -BeNullOrEmpty
        
            Should -Invoke -CommandName  Get-MgBetaApplicationTemplate -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain Id in result" {
            $result = Get-EntraBetaMSApplicationTemplate -Id "5979191c-86e6-40f7-87ac-0913dddd1f61"
            $result.Id | should -Be "5979191c-86e6-40f7-87ac-0913dddd1f61"

            Should -Invoke -CommandName Get-MgBetaApplicationTemplate -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        } 

        It "Should contain ApplicationTemplateId in parameters when passed Id to it" {
            $result = Get-EntraBetaMSApplicationTemplate -Id "5979191c-86e6-40f7-87ac-0913dddd1f61"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationTemplateId | Should -Be "5979191c-86e6-40f7-87ac-0913dddd1f61"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaMSApplicationTemplate"

            $result = Get-EntraBetaMSApplicationTemplate -Id "5979191c-86e6-40f7-87ac-0913dddd1f61"
            $params = Get-Parameters -data $result.Parameters
            $params.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }    
    }
}